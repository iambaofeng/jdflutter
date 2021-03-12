import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/model/CatProductModel.dart';
import 'package:get/get.dart';

class OrderInfoPage extends StatelessWidget {
  OrderInfoPageController vm = Get.put(OrderInfoPageController());

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
        title: Text('订单详情'),
      ),
      body: Container(
        child: ListView(
          children: [
            //收货地址
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: setHeight(20),
                    ),
                    ListTile(
                      leading: Icon(Icons.add_location),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('张三 15809603472'),
                          SizedBox(
                            height: setHeight(10),
                          ),
                          Text('火星')
                        ],
                      ),
                      // trailing: Icon(Icons.navigate_next),
                      // onTap: () {
                      //   Get.toNamed('/addressList');
                      // },
                    ),
                    SizedBox(
                      height: setHeight(20),
                    ),
                  ],
                )),
            SizedBox(
              height: setHeight(16),
            ),
            //商品详情
            Obx(() => Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(setWidth(20)),
                  child: Column(
                    children: vm.orderItemList
                        .map((element) => checkOutItem(element))
                        .toList(),
                  ),
                )),
            //详情信息
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: setHeight(20)),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          '订单编号：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('xxxxxxxx')
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          '下单日期：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('2019-12-09')
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          '支付方式：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('微信支付')
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          '配送方式：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('顺丰')
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: setHeight(16),
            ),
            //总金额
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: setHeight(20)),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          '总金额：',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('￥414元')
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderInfoPageController extends GetxController {
  final orderItemList = <Rx<CatProductModel>>[].obs;
}
