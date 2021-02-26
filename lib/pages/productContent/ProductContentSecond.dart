import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductContentSecond extends StatelessWidget {
  ProductContentSecondController vm = Get.put(ProductContentSecondController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('详情列表'),
    );
  }
}

class ProductContentSecondController extends GetxController {}
