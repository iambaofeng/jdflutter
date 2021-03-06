import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/pages/Cart/CartItem.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:flutter_jdshop/widgets/AppbarWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPageController vm = Get.put(CartPageController());
  CartServices cartServices = Get.find();

  List<Widget> getCartItemList() {
    return cartServices.cartList.map((element) {
      return CartItem(element);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print('build购物车页面了');
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: [
          IconButton(
              icon: Icon(Icons.launch),
              onPressed: () {
                vm.isEdit.value = !vm.isEdit.value;
              })
        ],
      ),
      body: Obx(() => cartServices.cartList.length > 0
          ? Stack(
              children: [
                ListView(
                  children: [
                    Column(
                      children: getCartItemList(),
                    ),
                    SizedBox(
                      height: setHeight(100),
                    )
                  ],
                ),
                Positioned(
                  child: vm.isEdit.value == false
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(
                                      width: 1, color: Colors.black12))),
                          child: Stack(
                            children: [
                              //左侧全选
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Container(
                                      width: setWidth(60),
                                      child: Checkbox(
                                        value: cartServices.isCheckedAll.value,
                                        onChanged: (value) {
                                          cartServices.changeAllSelected();
                                        },
                                        activeColor: Colors.pink,
                                      ),
                                    ),
                                    Text('全选'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('合计:'),
                                    Text(
                                      '￥${cartServices.allPrice.value}',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    vm.doCheckOut();
                                  },
                                  child: Text(
                                    '结算',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  // color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          // color: Colors.red,
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(
                                      width: 1, color: Colors.black12))),
                          child: Stack(
                            children: [
                              //左侧全选
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Container(
                                      width: setWidth(60),
                                      child: Checkbox(
                                        value: cartServices.isCheckedAll.value,
                                        onChanged: (value) {
                                          cartServices.changeAllSelected();
                                        },
                                        activeColor: Colors.pink,
                                      ),
                                    ),
                                    Text('全选'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartServices.removeItem();
                                  },
                                  child: Text(
                                    '删除',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // color: Colors.orange,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange)),
                                ),
                              )
                            ],
                          ),
                          // color: Colors.red,
                        ),
                  bottom: 0,
                  width: setWidth(750),
                  height: setHeight(78),
                )
              ],
            )
          : Center(
              child: Text(vm._title.value),
            )),
    );
  }
}

class CartPageController extends GetxController {
  final _title = '购物车空空的.....'.obs;
  final isEdit = false.obs;
  CartServices cartServices = Get.find();
  UserServices userServices = Get.find();

//去结算
  doCheckOut() {
    if (userServices.userinfo.value.tel == "") {
      SmartDialog.showToast('还未登录请先登录',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));

      Get.toNamed('/login');
    } else if (cartServices.cartList
        .every((element) => element.value.checked == false)) {
      SmartDialog.showToast('购物车没有选择的商品',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));
    } else {
      Get.toNamed('/checkOut');
    }
  }
}
