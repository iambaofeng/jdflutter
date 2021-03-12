import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
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
            child: ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('订单编号：xxxxxxxxx'),
                      ),
                      SizedBox(
                        height: setHeight(20),
                      ),
                      ListTile(
                        leading: Container(
                          width: setWidth(80),
                          height: setHeight(80),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('文字'),
                        trailing: Text('x1'),
                      ),
                      SizedBox(
                        height: setHeight(20),
                      ),
                      ListTile(
                        leading: Text('合计：￥345'),
                        trailing: TextButton(
                          child: Text('申请售后'),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('订单编号：xxxxxxxxx'),
                      ),
                      SizedBox(
                        height: setHeight(20),
                      ),
                      ListTile(
                        leading: Container(
                          width: setWidth(80),
                          height: setHeight(80),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('文字'),
                        trailing: Text('x1'),
                      ),
                      SizedBox(
                        height: setHeight(20),
                      ),
                      ListTile(
                        leading: Text('合计：￥345'),
                        trailing: TextButton(
                          child: Text('申请售后'),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('订单编号：xxxxxxxxx'),
                      ),
                      SizedBox(
                        height: setHeight(20),
                      ),
                      ListTile(
                        leading: Container(
                          width: setWidth(80),
                          height: setHeight(80),
                          child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text('文字'),
                        trailing: Text('x1'),
                      ),
                      SizedBox(
                        height: setHeight(20),
                      ),
                      ListTile(
                        leading: Text('合计：￥345'),
                        trailing: TextButton(
                          child: Text('申请售后'),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            width: setWidth(750),
            height: setHeight(76),
            top: 0,
            child: Container(
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
                    child: Text('全部', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('全部', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('全部', textAlign: TextAlign.center),
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

class OrderPageController extends GetxController {}
