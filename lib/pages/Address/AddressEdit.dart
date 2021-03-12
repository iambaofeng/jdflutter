import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/http/Api.dart';
import 'package:flutter_jdshop/http/http.dart';
import 'package:flutter_jdshop/pages/Address/AddressList.dart';
import 'package:flutter_jdshop/services/SignServices.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_jdshop/widgets/jdTextWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class AddressEditPage extends StatelessWidget {
  AddressEditPageController vm = Get.put(AddressEditPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.all(setWidth(20)),
        child: ListView(
          children: [
            jdText(
              controller: vm.nameController,
              text: '收货人姓名：',
              onChanged: (value) {
                vm.name = value;
              },
            ),
            SizedBox(
              height: setHeight(20),
            ),
            jdText(
              controller: vm.phoneController,
              text: '收货人电话：',
              onChanged: (value) {
                vm.phone = value;
              },
            ),
            SizedBox(
              height: setHeight(20),
            ),
            Container(
              padding: EdgeInsets.only(left: setWidth(10)),
              height: setHeight(68),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                      context: context,
                      cancelWidget: Text(
                        '取消',
                        style: TextStyle(color: Colors.black54),
                      ),
                      confirmWidget: Text(
                        '确定',
                        style: TextStyle(color: Colors.black54),
                      ));
                  if (result != null) {
                    vm.area.value =
                        "${result.provinceName}/${result.cityName}/${result.areaName}";
                  }

                  print(result);
                },
                child: Row(
                  children: [
                    Icon(Icons.add_location),
                    Obx(() => vm.area.value == ''
                        ? Text(
                            '省/市/区',
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text(
                            '${vm.area.value}',
                            style: TextStyle(color: Colors.black54),
                          ))
                  ],
                ),
              ),
            ),
            // ElevatedButton(onPressed: () async {}, child: Text('选择区划')),
            jdText(
              controller: vm.addressController,
              text: '详细地址：',
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                vm.address = "${vm.area.value} ${value}";
              },
            ),
            SizedBox(
              height: setHeight(80),
            ),
            JdButton(
              text: '修改',
              color: Colors.red,
              cb: () {
                vm.editAddress();
              },
            )
          ],
        ),
      ),
    );
  }
}

class AddressEditPageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  AddressListPageController addressListPageController = Get.find();
  SignServices signServices = Get.find();
  UserServices userServices = Get.find();
  String name = '';
  String phone = '';
  String address = '';
  final area = "".obs;
  Map<String, dynamic> tmpJson = {};
  @override
  void onInit() {
    // fetchApi();
    nameController.text = Get.arguments.name;
    name = Get.arguments.name;
    phoneController.text = Get.arguments.phone;
    phone = Get.arguments.phone;
    addressController.text = Get.arguments.address.split(' ')[1];
    address = Get.arguments.address.split(' ')[1];
    area.value = Get.arguments.address.split(' ')[0];
    super.onInit();
  }

  String getSgin() {
    tmpJson = {
      "uid": userServices.userinfo.value.sId,
      "id": Get.arguments.sId,
      "name": name,
      "phone": phone,
      "address": address,
      'salt': userServices.userinfo.value.salt
    };
    print(tmpJson);
    return signServices.getSign(tmpJson);
  }

  void editAddress() async {
    var result = await Http().post(Api.EDIT_ADDRESS, data: {
      "uid": userServices.userinfo.value.sId,
      "id": Get.arguments.sId,
      "name": name,
      "phone": phone,
      "address": address,
      "sign": getSgin()
    });
    if (result['success']) {
      SmartDialog.showToast('修改成功', alignment: Alignment.center);
      addressListPageController.getAddressList();
      Get.back();
    } else {
      SmartDialog.showToast(result['message'], alignment: Alignment.center);
    }
  }
}
