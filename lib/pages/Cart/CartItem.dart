import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/model/CatProductModel.dart';
import 'package:get/get.dart';

import 'CartNumber.dart';

class CartItem extends StatelessWidget {
  Rx<CatProductModel> data;
  CartItemController vm = Get.put(CartItemController());
  CartItem(this.data);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        padding: EdgeInsets.all(5),
        height: setHeight(200),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            //单选
            Container(
              width: setWidth(60),
              child: Checkbox(
                value: data.value.checked,
                onChanged: (value) {},
                activeColor: Colors.pink,
              ),
            ),
            //图片
            Container(
              width: setWidth(160),
              child: Image.network(
                data.value.pic,
                fit: BoxFit.cover,
              ),
            ),
            //信息
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.value.title,
                        maxLines: 2,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data.value.price,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CartNumber(data),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        )));
  }
}

class CartItemController extends GetxController {}
