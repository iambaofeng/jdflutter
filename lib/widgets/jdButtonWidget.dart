import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

class JdButton extends StatelessWidget {
  // JdButtonController vm = Get.put(JdButtonController());

  final Color color;
  final String text;
  final void Function()? cb;
  final double height;
  JdButton(
      {this.color = Colors.black,
      this.text = '按钮',
      this.cb = null,
      this.height = 68});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.cb,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        height: setHeight(height),
        decoration: BoxDecoration(
            color: this.color, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// class JdButtonController extends GetxController {}
