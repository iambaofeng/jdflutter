import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/pages/Register/RegisterFirst.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_jdshop/widgets/jdTextWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class RegisterSecondPage extends StatelessWidget {
  RegisterSecondPageController vm = Get.put(RegisterSecondPageController());
  RegisterFirstPageController first = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第二步'),
      ),
      body: Container(
        padding: EdgeInsets.all(setWidth(20)),
        child: ListView(
          children: [
            SizedBox(
              height: setHeight(30),
            ),
            Container(
                margin: EdgeInsets.all(
                  setWidth(20),
                ),
                child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(text: '验证码已发送到了您的'),
                        TextSpan(
                            text: '${first.tel}',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(text: '，请输入'),
                        TextSpan(
                            text: '${first.tel}',
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(text: '手机收到的验证码')
                      ]),
                )),
            Obx(() => Stack(
                  children: [
                    jdText(
                        text: '请输入验证码',
                        isPassword: false,
                        onChanged: (value) {
                          vm.code = value;
                          // print(value);
                        }),
                    vm.sendCodeBtn.value
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: ElevatedButton(
                                child: Text('重新发送'),
                                onPressed: () {
                                  vm._sendCode();
                                }))
                        : Positioned(
                            right: 0,
                            top: 0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black12),
                              ),
                              child: Text('${vm.seconds.value}s'),
                            )),
                  ],
                )),
            SizedBox(
              height: setHeight(20),
            ),
            JdButton(
              text: '下一步',
              color: Colors.pink,
              height: 74,
              cb: () {
                vm.checkCode();
              },
            )
          ],
        ),
      ),
    );
  }
}

class RegisterSecondPageController extends GetxController {
  RegisterFirstPageController first = Get.find();
  final sendCodeBtn = false.obs;
  final seconds = 10.obs;
  String code = "";
  @override
  void onInit() {
    // TODO: implement onInit
    print('初始化了');
    _showTimer();
    super.onInit();
  }

  void _showTimer() {
    Timer t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
        sendCodeBtn.value = true;
      }
    });
  }

  void _sendCode() async {
    await first.sendCode();
    seconds.value = 10;
    sendCodeBtn.value = false;

    _showTimer();
  }

  checkCode() async {
    String api = "${Config.domain}api/validateCode";
    var response =
        await Dio().post(api, data: {"tel": first.tel, 'code': code});

    if (response.data['success']) {
      SmartDialog.showToast('验证成功',
          alignment: Alignment.center, time: Duration(milliseconds: 3000));
      Get.toNamed('registerThird');
    } else {
      SmartDialog.showToast(response.data['message'],
          alignment: Alignment.center);
    }
  }
}
