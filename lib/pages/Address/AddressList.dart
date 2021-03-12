import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/http/Api.dart';
import 'package:flutter_jdshop/http/http.dart';
import 'package:flutter_jdshop/model/AddressItemModel.dart';
import 'package:flutter_jdshop/pages/CheckOut.dart';
import 'package:flutter_jdshop/services/SignServices.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:get/get.dart';

class AddressListPage extends StatelessWidget {
  AddressListPageController vm = Get.put(AddressListPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收获地址列表'),
      ),
      body: Container(
          child: Stack(
        children: [
          Obx(() => ListView.builder(
              itemCount: vm.addressList.length,
              itemBuilder: (context, index) {
                if (vm.addressList[index].value.defaultAddress == 1) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.check,
                          color: Colors.red,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${vm.addressList[index].value.name}  ${vm.addressList[index].value.phone}'),
                            SizedBox(
                              height: setHeight(10),
                            ),
                            Text('${vm.addressList[index].value.address}')
                          ],
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      Divider(
                        height: setHeight(20),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ListTile(
                        title: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${vm.addressList[index].value.name}  ${vm.addressList[index].value.phone}'),
                              SizedBox(
                                height: setHeight(10),
                              ),
                              Text('${vm.addressList[index].value.address}')
                            ],
                          ),
                          onTap: () {
                            vm.changeDefaultAddress(
                                vm.addressList[index].value.sId);
                          },
                        ),
                        trailing: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      Divider(
                        height: setHeight(20),
                      ),
                    ],
                  );
                }
              })),
          Positioned(
              bottom: 0,
              width: setWidth(750),
              height: setHeight(88),
              child: Container(
                padding: EdgeInsets.all(setWidth(10)),
                height: setHeight(100),
                // color: Colors.red,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        '增加收货地址',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/addressAdd');
                  },
                ),
              ))
        ],
      )),
    );
  }
}

class AddressListPageController extends GetxController {
  SignServices signServices = Get.find();
  UserServices userServices = Get.find();
  CheckOutPageController checkOutPageController = Get.find();
  final addressList = <Rx<AddressItemModel>>[].obs;

  @override
  void onInit() {
    getAddressList();
    super.onInit();
  }

  String getSgin() {
    Map<String, dynamic> tmpJson = {
      "uid": userServices.userinfo.value.sId,
      'salt': userServices.userinfo.value.salt
    };
    print(tmpJson);
    return signServices.getSign(tmpJson);
  }

  void getAddressList() async {
    addressList.clear();
    var result = await Http().get(Api.ADDRESS_LIST,
        data: {'uid': userServices.userinfo.value.sId, 'sign': getSgin()});
    addressList.addAll(AddressModel.fromJson(result).result);
  }

  void changeDefaultAddress(id) async {
    var result = await Http().post(Api.CHANGE_DEFAULT_ADDRESS, params: {
      'uid': userServices.userinfo.value.sId,
      'id': id,
      'sign': signServices.getSign({
        "uid": userServices.userinfo.value.sId,
        'salt': userServices.userinfo.value.salt,
        'id': id
      })
    });
    if (result['success']) {
      getAddressList();
      checkOutPageController.getDefaultAddress();
      Get.back();
    }
  }
}
