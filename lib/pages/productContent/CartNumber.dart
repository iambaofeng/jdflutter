import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/pages/ProductContent.dart';
import 'package:get/get.dart';

class ProductContentCartNumber extends StatelessWidget {
  ProductContentCartNumberController vm =
      Get.put(ProductContentCartNumberController());
  ProductContentController productContent = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: setWidth(164),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12)),
          child: Row(
            children: [_leftBtn(), _centerArea(), _rightBtn()],
          ),
        ));
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
          if (productContent.productContentData.value.count > 1) {
            productContent.productContentData.update((data) {
              data.count--;
            });
          }
        });
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
        // productContent.productContentData.value.count.value++;
        productContent.productContentData.update((value) {
          value.count++;
        });
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
      child: Text('${productContent.productContentData.value.count}'),
    );
  }
}

class ProductContentCartNumberController extends GetxController {}
