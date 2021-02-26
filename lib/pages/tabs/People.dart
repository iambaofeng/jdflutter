import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeoplePage extends StatelessWidget {
  PeoplePageController vm = Get.put(PeoplePageController());

  @override
  Widget build(BuildContext context) {
    return Text('我的');
  }
}

class PeoplePageController extends GetxController {}
