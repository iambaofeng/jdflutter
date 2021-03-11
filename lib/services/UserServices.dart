import 'dart:convert';

import 'package:flutter_jdshop/model/UserrInfo.dart';
import 'package:flutter_jdshop/services/Storage.dart';
import 'package:get/get.dart';

class UserServices extends GetxService {
  final userinfo = UserInfoModel(sId: '', salt: "", tel: "", username: "").obs;

  @override
  void onInit() {
    getUserInfoData();
    super.onInit();
  }

  getUserInfoData() async {
    var data = await Storage.getString('userinfo');
    if (data != '') {
      //有数据
      Map<String, dynamic> res = json.decode(data);
      userinfo(UserInfoModel.fromJson(res));
    }
  }

  setUserInfoData(data) async {
    userinfo(UserInfoModel.fromJson(data));

    await Storage.setString('userinfo', json.encode(data));
  }

  loginOut() async {
    await Storage.remove('userinfo');
    userinfo(UserInfoModel(sId: '', salt: "", tel: "", username: ""));
  }
}
