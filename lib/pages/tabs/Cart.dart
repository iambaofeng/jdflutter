import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widgets/AppbarWidget.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPageController vm = Get.put(CartPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(),
    );
  }
}

class CartPageController extends GetxController {}
