import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/model/pay_model.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:get/get.dart';

class PayPage extends StatelessWidget {
  PayPageController vm = Get.put(PayPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('去支付'),
      ),
      body: Container(
        padding: EdgeInsets.all(setWidth(20)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: setHeight(40)),
              height: setHeight(400),
              child: Obx(() => ListView(
                  children: vm.payList
                      .map((element) => Column(
                            children: [
                              ListTile(
                                leading: Image.asset(element.value.iconUrl),
                                title: Text(element.value.title),
                                trailing: element.value.checked
                                    ? Icon(Icons.check)
                                    : Text(''),
                                onTap: () {
                                  vm.payList.forEach((element) {
                                    element.update((val) {
                                      val.checked = false;
                                    });
                                  });

                                  element.update((val) {
                                    val.checked = true;
                                  });
                                },
                              ),
                              Divider(
                                height: setHeight(30),
                              )
                            ],
                          ))
                      .toList())),
            ),
            JdButton(
              text: '支付',
              color: Colors.red,
              height: 74,
              cb: () {},
            )
          ],
        ),
      ),
    );
  }
}

class PayPageController extends GetxController {
  final payList = <Rx<PayItemModel>>[].obs;

  @override
  void onInit() {
    payList.add(
        PayItemModel(title: '支付宝', iconUrl: "images/alipay.png", checked: true)
            .obs);
    payList.add(PayItemModel(
            title: '微信支付', iconUrl: "images/weixinpay.png", checked: false)
        .obs);
    super.onInit();
  }
}
