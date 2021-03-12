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
    //删除弹出框
    _showAlertDialog(id) async {
      var result = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示信息！'),
              content: Text('您确定要删除该条收货地址吗？'),
              actions: [
                TextButton(
                    onPressed: () {
                      print('取消');
                      Navigator.pop(context, 'Cancle');
                    },
                    child: Text('取消')),
                TextButton(
                    onPressed: () {
                      print('确定');
                      vm.deleteAddress(id);
                      Navigator.pop(context, 'ok');
                    },
                    child: Text('确定'))
              ],
            );
          });
    }

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
                        onLongPress: () {
                          _showAlertDialog(vm.addressList[index].value.sId);
                        },
                        leading: Icon(
                          Icons.check,
                          color: Colors.red,
                        ),
                        title: InkWell(
                          onTap: () {
                            vm.changeDefaultAddress(
                                vm.addressList[index].value.sId);
                          },
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
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () {
                            Get.toNamed('/addressEdit',
                                arguments: vm.addressList[index].value);
                          },
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
                        onLongPress: () {
                          _showAlertDialog(vm.addressList[index].value.sId);
                        },
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
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () {
                            Get.toNamed('/addressEdit',
                                arguments: vm.addressList[index].value);
                          },
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

  @override
  void onClose() {
    checkOutPageController.getDefaultAddress();
    super.onClose();
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
    // addressList.clear();
    var result = await Http().get(Api.ADDRESS_LIST,
        data: {'uid': userServices.userinfo.value.sId, 'sign': getSgin()});
    addressList(AddressModel.fromJson(result).result);
  }

  void changeDefaultAddress(id) async {
    var result = await Http().post(Api.CHANGE_DEFAULT_ADDRESS, data: {
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

      Get.back();
    }
  }

  void deleteAddress(id) async {
    var result = await Http().post(Api.DELETE_ADDRESS, data: {
      'uid': userServices.userinfo.value.sId,
      "id": id,
      'sign': signServices.getSign({
        "uid": userServices.userinfo.value.sId,
        'salt': userServices.userinfo.value.salt,
        "id": id
      })
    });
    if (result['success']) {
      getAddressList();
    }
  }
}
