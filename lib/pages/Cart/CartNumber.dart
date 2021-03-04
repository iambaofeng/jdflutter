import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/model/CatProductModel.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:get/get.dart';

class CartNumber extends StatelessWidget {
  CartNumberController vm = Get.put(CartNumberController());
  CartServices cartServices = Get.find();
  Rx<CatProductModel> data;
  CartNumber(this.data);
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
      onTap: () {
        if (data.value.count > 0) {
          data.update((val) {
            val.count--;
          });
          cartServices.updataCartList();
        }
      },
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
      onTap: () {
        data.update((val) {
          val.count++;
        });
        cartServices.updataCartList();
      },
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
      child: Text('${data.value.count}'),
    );
  }
}

class CartNumberController extends GetxController {}
