import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';

class SignServices extends GetxService {
  @override
  void onInit() {
    // getSign('123');
    super.onInit();
  }

  String getSign(Map<String, dynamic> json) {
    // Map addressListAttr = {
    //   "uid": '1',
    //   "age": 10,
    //   "salt": 'xxxxxxxxxxxx' //私钥
    // };

    var attrKey = json.keys.toList();
    attrKey.sort(); //排序 按照ASCII 字符顺序进行升序排序

    // print(attrKey);
    String str = "";
    for (var i = 0; i < attrKey.length; i++) {
      str += "${attrKey[i]}${json[attrKey[i]]}";
    }
    // print(str);

    str = md5.convert(utf8.encode(str)).toString();
    // print(str);

    return str;
  }
}
