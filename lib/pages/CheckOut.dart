import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/model/CatProductModel.dart';
import 'package:flutter_jdshop/pages/Cart/CartNumber.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
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
                    // ListTile(
                    //   leading: Icon(Icons.add_location),
                    //   title: Center(
                    //     child: Text('请添加收货地址'),
                    //   ),
                    //   trailing: Icon(Icons.navigate_next),
                    //   onTap: () {
                    //     Get.toNamed('/addressAdd');
                    //   },
                    // ),
                    ListTile(
                      // leading: Icon(Icons.add_location),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('张三 15809603472'),
                          SizedBox(
                            height: setHeight(10),
                          ),
                          Text('北京市海淀区西二旗')
                        ],
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Get.toNamed('/addressList');
                      },
                    ),
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
                        onPressed: () {},
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

  final checkItemList = <Rx<CatProductModel>>[].obs;
  double checkItemSum = 0.0;
  double orderSum = 0.0;
  double discount = 5.0;
  double shipiing = 0.0;
  @override
  void onInit() {
    getCheckList();
    calculateOrderSum();
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
}