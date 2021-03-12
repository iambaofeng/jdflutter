import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/http/Api.dart';
import 'package:flutter_jdshop/http/http.dart';
import 'package:flutter_jdshop/model/AddressItemModel.dart';
import 'package:flutter_jdshop/model/CatProductModel.dart';
import 'package:flutter_jdshop/pages/Cart/CartNumber.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:flutter_jdshop/services/SignServices.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  CheckOutPageController vm = Get.put(CheckOutPageController());

  Widget checkOutItem(data) {
    return Container(
        padding: EdgeInsets.all(setWidth(5)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: setWidth(1), color: Colors.black12))),
        child: Row(
          children: [
            //图片
            Container(
              width: setWidth(160),
              padding: EdgeInsets.all(setWidth(10)),
              child: Image.network(
                data.value.pic,
                fit: BoxFit.cover,
              ),
            ),
            //信息
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      setWidth(10), setWidth(10), setWidth(5), setWidth(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.value.title,
                        maxLines: 2,
                      ),
                      Text(
                        data.value.selectedAttr,
                        maxLines: 2,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "￥${data.value.price}",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('x${data.value.count}'),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品结算'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: setHeight(10),
                    ),
                    Obx(() => vm.addressList.length == 0
                        ? ListTile(
                            leading: Icon(Icons.add_location),
                            title: Center(
                              child: Text('请添加收货地址'),
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Get.toNamed('/addressAdd');
                            },
                          )
                        : ListTile(
                            // leading: Icon(Icons.add_location),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${vm.addressList[0].value.name} ${vm.addressList[0].value.phone}'),
                                SizedBox(
                                  height: setHeight(10),
                                ),
                                Text('${vm.addressList[0].value.address}')
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Get.toNamed('/addressList');
                            },
                          )),
                    SizedBox(
                      height: setHeight(10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: setHeight(20),
              ),
              Obx(() => Container(
                    padding: EdgeInsets.all(setWidth(20)),
                    child: Column(
                      children: vm.checkItemList
                          .map((element) => checkOutItem(element))
                          .toList(),
                    ),
                  )),
              SizedBox(
                height: setHeight(40),
              ),
              Container(
                padding: EdgeInsets.all(setWidth(20)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('商品总金额：￥${vm.checkItemSum}'),
                    Divider(),
                    Text('立减：￥${vm.discount}'),
                    Divider(),
                    Text('运费：￥${vm.shipiing}')
                  ],
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              width: setWidth(750),
              height: setHeight(100),
              child: Container(
                padding: EdgeInsets.all(setWidth(10)),
                height: setHeight(100),
                // color: Colors.red,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '总价：￥${vm.orderSum}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child: Text('立即下单'),
                        onPressed: () {
                          vm.putOrder();
                        },
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                TextStyle(color: Colors.white)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class CheckOutPageController extends GetxController {
  CartServices cartServices = Get.find();
  UserServices userServices = Get.find();
  SignServices signServices = Get.find();

  final checkItemList = <Rx<CatProductModel>>[].obs;
  final defaultAddress = AddressItemModel().obs;
  final addressList = <Rx<AddressItemModel>>[].obs;

  double checkItemSum = 0.0;
  double orderSum = 0.0;
  double discount = 5.0;
  double shipiing = 0.0;
  @override
  void onInit() {
    getCheckList();
    calculateOrderSum();
    getDefaultAddress();
    super.onInit();
  }

  void getCheckList() {
    checkItemList.addAll(cartServices.cartList.where((value) {
      if (value.value.checked == true) {
        checkItemSum += value.value.price * value.value.count;
        return true;
      } else {
        return false;
      }
    }).toList());
  }

  void calculateOrderSum() {
    orderSum = checkItemSum - discount + shipiing;
  }

  void getDefaultAddress() async {
    // addressList.clear();
    var result = await Http().get(Api.ONE_ADDRESS_LIST, data: {
      'uid': userServices.userinfo.value.sId,
      'sign': signServices.getSign({
        "uid": userServices.userinfo.value.sId,
        'salt': userServices.userinfo.value.salt
      })
    });
    // defaultAddress(AddressItemModel.fromJson(result));
    addressList(AddressModel.fromJson(result).result);
  }

  putOrder() async {
    if (addressList.length == 0) {
      SmartDialog.showToast('必须选择收货地址！', alignment: Alignment.center);
      return false;
    }
    Map<String, dynamic> params = {
      "uid": userServices.userinfo.value.sId,
      "address": addressList[0].value.address,
      'phone': addressList[0].value.phone,
      "name": addressList[0].value.name,
      "all_price": orderSum.toStringAsFixed(1),
      "products":
          json.encode(checkItemList.map((element) => element.value).toList()),
      "sign": signServices.getSign({
        "uid": userServices.userinfo.value.sId,
        'salt': userServices.userinfo.value.salt,
        "address": addressList[0].value.address,
        'phone': addressList[0].value.phone,
        "name": addressList[0].value.name,
        "all_price": orderSum.toStringAsFixed(1),
        "products":
            json.encode(checkItemList.map((element) => element.value).toList()),
      })
    };

    var result = await Http().post(Api.DO_ORDER, data: params);

    if (result['success']) {
      //删除购物车选中的商品
      cartServices.removeItem();
      Get.toNamed('/pay');
      print('提交成功');
    }
  }
}
