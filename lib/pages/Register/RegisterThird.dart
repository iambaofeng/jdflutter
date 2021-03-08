import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/pages/Register/RegisterFirst.dart';
import 'package:flutter_jdshop/pages/Register/RegisterSecond.dart';
import 'package:flutter_jdshop/pages/Tab.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_jdshop/widgets/jdTextWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class RegisterThirdPage extends StatelessWidget {
  final RegisterThirdPageController vm = Get.put(RegisterThirdPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第三步'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: setHeight(50),
            ),
            jdText(
                text: '请输入密码',
                isPassword: true,
                onChanged: (value) {
                  vm.password = value;
                }),
            SizedBox(
              height: setHeight(50),
            ),
            jdText(
                text: '请输入确认密码',
                isPassword: true,
                onChanged: (value) {
                  vm.repeatPassword = value;
                }),
            SizedBox(
              height: setHeight(50),
            ),
            JdButton(
              text: '注册并登录',
              color: Colors.pink,
              height: 74,
              cb: () {
                vm.register();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterThirdPageController extends GetxController {
  RegisterFirstPageController first = Get.find();
  RegisterSecondPageController second = Get.find();
  UserServices userServices = Get.find();
  TabsController tabsController = Get.find();
  String password = '';
  String repeatPassword = '';

  void checkPassword() {
    if (password != repeatPassword) {
      SmartDialog.showToast('两次输入的密码不一致',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));
    } else if (password.length < 6) {
      SmartDialog.showToast('密码长度不得小于6位',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));
    } else {
      register();
    }
  }

  void register() async {
    String api = "${Config.domain}api/register";
    var response = await Dio().post(api,
        data: {"tel": first.tel, 'code': second.code, 'password': password});

    if (response.data['success']) {
      SmartDialog.showToast('注册成功',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));

      userServices.setUserInfoData(response.data['userinfo'][0]);
      tabsController.currentIndex.value = 0;
      //保存用户信息，返回到根
      Get.offAllNamed('/');
    } else {
      SmartDialog.showToast(response.data['message'],
          alignment: Alignment.center);
    }
  }
}
