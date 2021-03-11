import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_jdshop/widgets/jdTextWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPageController vm = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Get.back();
            }),
        title: Text('登录页面'),
        actions: [TextButton(onPressed: () {}, child: Text('客服'))],
      ),
      body: Container(
        padding: EdgeInsets.all(
          setWidth(30),
        ),
        child: ListView(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: setHeight(60)),
                height: setHeight(160),
                width: setWidth(160),
                child: Image.asset(
                  'images/login.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            jdText(
                text: '请输入用户名',
                isPassword: false,
                onChanged: (value) {
                  vm.username = value;
                  // print(value);
                }),
            SizedBox(
              height: setHeight(20),
            ),
            jdText(
              text: '请输入密码',
              isPassword: true,
              onChanged: (value) {
                vm.password = value;
                // print(value);
              },
            ),
            SizedBox(
              height: setHeight(20),
            ),
            Container(
              padding: EdgeInsets.all(setWidth(20)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/registerFirst');
                      },
                      child: Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),
            JdButton(
              text: '登录',
              color: Colors.pink,
              height: 74,
              cb: () {
                vm.login();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPageController extends GetxController {
  String username = '';
  String password = '';

  UserServices userServices = Get.find();

  login() async {
    RegExp reg = RegExp(r"^1\d{10}$");

    if (!reg.hasMatch(username)) {
      SmartDialog.showToast('手机格式不正确',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));
    } else if (password.length < 6) {
      SmartDialog.showToast('密码不正确',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));
    } else {
      String api = "${Config.domain}api/doLogin";
      var response = await Dio()
          .post(api, data: {"username": username, 'password': password});

      if (response.data['success']) {
        SmartDialog.showToast('登陆成功',
            alignment: Alignment.center, time: Duration(milliseconds: 3000));

        userServices.setUserInfoData(response.data['userinfo'][0]);
        // tabsController.currentIndex.value = 0;
        //保存用户信息，返回到根
        Get.back();
      } else {
        SmartDialog.showToast(response.data['message'],
            alignment: Alignment.center);
      }
    }
  }
}
