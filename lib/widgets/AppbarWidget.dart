import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

AppBar searchAppBar() {
  return AppBar(
    leading: IconButton(
        icon: Icon(
          Icons.center_focus_weak,
          color: Colors.black87,
          size: 28,
        ),
        onPressed: null),
    actions: [
      IconButton(
          icon: Icon(
            Icons.message,
            color: Colors.black87,
            size: 28,
          ),
          onPressed: null)
    ],
    title: InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        height: setHeight(68),
        decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Text(
              '笔记本',
              style: TextStyle(fontSize: setFontSize(28)),
            )
          ],
        ),
      ),
      onTap: () {
        Get.toNamed('/search');
      },
    ),
  );
}
