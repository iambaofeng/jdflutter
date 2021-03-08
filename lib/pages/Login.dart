import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_jdshop/widgets/jdTextWidget.dart';
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
                  print(value);
                }),
            SizedBox(
              height: setHeight(20),
            ),
            jdText(
              text: '请输入密码',
              isPassword: true,
              onChanged: (value) {
                print(value);
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
              cb: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPageController extends GetxController {}
