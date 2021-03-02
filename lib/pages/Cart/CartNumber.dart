import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

class CartNumber extends StatelessWidget {
  CartNumberController vm = Get.put(CartNumberController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: setWidth(164),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: [_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }

  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: setWidth(45),
        height: setHeight(45),
        child: Text('-'),
      ),
      onTap: () {},
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: setWidth(45),
        height: setHeight(45),
        child: Text('+'),
      ),
      onTap: () {},
    );
  }

  //中间按钮
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12))),
      width: setWidth(70),
      height: setHeight(45),
      child: Text('1'),
    );
  }
}

class CartNumberController extends GetxController {}
