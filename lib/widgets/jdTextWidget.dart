import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

class jdText extends StatelessWidget {
  jdTextController vm = Get.put(jdTextController());
  final String text;
  final bool isPassword;
  final Object onChanged;
  jdText({this.text, this.isPassword, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: isPassword,
        autofocus: true,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: onChanged,
      ),
      height: setHeight(68),
      decoration: BoxDecoration(
          // color: Color.fromRGBO(233, 233, 233, 0.8),
          // borderRadius: BorderRadius.circular(30)
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
    );
  }
}

class jdTextController extends GetxController {}
