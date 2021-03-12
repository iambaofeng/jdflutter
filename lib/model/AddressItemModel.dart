import 'package:get/get.dart';

class AddressModel {
  final result = <Rx<AddressItemModel>>[].obs;

  AddressModel();

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result.add(new AddressItemModel.fromJson(v).obs);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result.map((v) => v.toJson()).toList();
    return data;
  }
}

class AddressItemModel {
  late String sId;
  late String uid;
  late String name;
  late String phone;
  late String address;
  late int defaultAddress;
  late int status;
  late int addTime;
  AddressItemModel(
      {this.sId = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.address = '',
      this.defaultAddress = 0,
      this.status = 0,
      this.addTime = 0});

  AddressItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    defaultAddress = json['default_address'];
    addTime = json['add_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['default_address'] = this.defaultAddress;
    data['add_time'] = this.addTime;
    return data;
  }
}
