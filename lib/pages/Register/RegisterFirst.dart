import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/pages/Register/RegisterSecond.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_jdshop/widgets/jdTextWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class RegisterFirstPage extends StatelessWidget {
  RegisterFirstPageController vm = Get.put(RegisterFirstPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第一步'),
      ),
      body: Container(
        padding: EdgeInsets.all(setWidth(20)),
        child: ListView(
          children: [
            SizedBox(
              height: setHeight(30),
            ),
            jdText(
                text: '请输入手机号',
                isPassword: false,
                onChanged: (value) {
                  vm.tel = value;
                }),
            SizedBox(
              height: setHeight(20),
            ),
            JdButton(
              text: '下一步',
              color: Colors.pink,
              height: 74,
              cb: () {
                vm.sendCode();
              },
            )
          ],
        ),
      ),
    );
  }
}

class RegisterFirstPageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit

    print('初始化了');
    super.onInit();
  }

  String tel = '';

  sendCode() async {
    RegExp mobileReg = RegExp(r"^1\d{10}$");
    if (mobileReg.hasMatch(tel)) {
      String api = "${Config.domain}api/sendCode";
      var response = await Dio().post(api, data: {"tel": tel});

      if (response.data['success']) {
        SmartDialog.showToast('手机验证码是${response.data["code"]}',
            alignment: Alignment.center, time: Duration(milliseconds: 3000));
        Get.toNamed('registerSecond');
      } else {
        SmartDialog.showToast(response.data['message'],
            alignment: Alignment.center);
      }

      print('正确');
    } else {
      SmartDialog.showToast('手机号格式不对！', alignment: Alignment.center);
      print('错误');
    }
  }
}
