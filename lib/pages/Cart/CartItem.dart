import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

import 'CartNumber.dart';

class CartItem extends StatelessWidget {
  CartItemController vm = Get.put(CartItemController());

  @override
  Widget build(BuildContext context) {
    return Container(
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
                value: true,
                onChanged: (value) {},
                activeColor: Colors.pink,
              ),
            ),
            //图片
            Container(
              width: setWidth(160),
              child: Image.network(
                'https://www.itying.com/images/flutter/list2.jpg',
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
                        '菲特旋转盖轻量杯不锈钢保温杯学生杯商务杯情侣杯保冷杯子便携水杯LHC4131WB(450M1)白蓝',
                        maxLines: 2,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '￥12',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CartNumber(),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}

class CartItemController extends GetxController {}
