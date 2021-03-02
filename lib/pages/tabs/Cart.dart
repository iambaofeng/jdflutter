import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/pages/Cart/CartItem.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:flutter_jdshop/widgets/AppbarWidget.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPageController vm = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: [IconButton(icon: Icon(Icons.launch), onPressed: () {})],
      ),
      body: Stack(
        children: [
          ListView(
            children: [CartItem(), CartItem(), CartItem()],
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black12))),
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
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.pink,
                          ),
                        ),
                        Text('全选')
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        '结算',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red,
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
      ),
    );
  }
}

class CartPageController extends GetxController {}
