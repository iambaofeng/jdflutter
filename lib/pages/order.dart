import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/http/Api.dart';
import 'package:flutter_jdshop/http/http.dart';
import 'package:flutter_jdshop/model/order_model.dart';
import 'package:flutter_jdshop/services/SignServices.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  OrderPageController vm = Get.put(OrderPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: setHeight(80)),
            padding: EdgeInsets.all(setWidth(16)),
            child: Obx(() => ListView(
                  children: vm.orderList
                      .map((element) => InkWell(
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '订单编号：${element.value.sId}',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  SizedBox(
                                    height: setHeight(20),
                                  ),
                                  Column(
                                    children: element.value.orderItem
                                        .map((item) => ListTile(
                                              leading: Container(
                                                width: setWidth(80),
                                                height: setHeight(80),
                                                child: Image.network(
                                                  item.value.productImg,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              title:
                                                  Text(item.value.productTitle),
                                              trailing: Text(
                                                  'x${item.value.productCount}'),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height: setHeight(20),
                                  ),
                                  ListTile(
                                    leading:
                                        Text('合计：￥${element.value.allPrice}'),
                                    trailing: TextButton(
                                      child: Text('申请售后'),
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Get.toNamed('/orderInfo',
                                  arguments: element.value);
                            },
                          ))
                      .toList(),
                )),
          ),
          Positioned(
            width: setWidth(750),
            height: setHeight(76),
            top: 0,
            child: Container(
              // margin: EdgeInsets.fromLTRB(setWidth(20), 0, setWidth(20), 0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '全部',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('代付款', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('待收货', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('已完成', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('已取消', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderPageController extends GetxController {
  UserServices userServices = Get.find();
  SignServices signServices = Get.find();

  @override
  void onInit() {
    getOrderList();
    super.onInit();
  }

  final orderList = <Rx<OrderList>>[].obs;

  void getOrderList() async {
    var result = await Http().get(Api.ORDER_LIST, data: {
      'uid': userServices.userinfo.value.sId,
      'sign': signServices.getSign({
        "uid": userServices.userinfo.value.sId,
        'salt': userServices.userinfo.value.salt
      })
    });
    orderList(OrderModel.fromJson(result).result);
  }
}
