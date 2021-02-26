import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductContentThird extends StatelessWidget {
  ProductContentThirdController vm = Get.put(ProductContentThirdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('评价'),
    );
  }
}

class ProductContentThirdController extends GetxController {}
