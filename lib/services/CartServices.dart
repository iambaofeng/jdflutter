import 'dart:convert';

import 'package:flutter_jdshop/model/CatProductModel.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';
import 'package:flutter_jdshop/services/Storage.dart';
import 'package:get/get.dart';

class CartServices extends GetxService {
  final str = ''.obs;
  final productAttrBottomSheet = false.obs;
  final cartList = [].obs;
  @override
  void onInit() async {
    // TODO: implement onInit

    var cartListData = await getCartListData();
    cartListData.forEach((item) {
      cartList.add(CatProductModel.fromJson(json.decode(item)).obs);
    });
    print(cartList);
    print(cartList[0]);
    super.onInit();
  }

  addCart(ProductContentItem item) async {
    //1.把对象转换成map类型的数据且筛选出有用的属性

    var cartProduct = json.encode(formatCartData(item));
    print(cartProduct);

    setCartListData(cartProduct);
  }

  getCartListData() async {
    var data = await Storage.getString('cartList');
    if (data != null) {
      //有数据
      List searchListData = json.decode(data);
      return searchListData;
    } else {
      //无数据
      return [];
    }
  }

  setCartListData(value) async {
    var data = await Storage.getString('cartList');
    if (data != null) {
      //有数据，判断购物车有没有这条同属性的商品，有的话在数量上+1，没有就新增一条商品
      List cartListData = json.decode(data);

      bool hasData = cartListData.any((element) {
        return element['_id'] == value['_id'] &&
            element['selectedAttr'] == value['selectedAttr'];
      });
      if (!hasData) {
        cartListData.add(value);
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        for (var i = 0; i < cartListData.length; i++) {
          if (cartListData[i]['_id'] == cartListData[i]['_id'] &&
              cartListData[i]['selectedAttr'] ==
                  cartListData[i]['selectedAttr']) {
            cartListData[i]['count']++;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } else {
      //无数据
      List tempList = [];
      tempList.add(value);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  Map formatCartData(ProductContentItem item) {
    final Map data = Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    data['checked'] = item.checked;
    return data;
  }
}
