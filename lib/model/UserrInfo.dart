class UserInfoModel {
  late String sId;
  late String username;
  late String tel;
  late String salt;

  UserInfoModel(
      {required this.sId,
      required this.username,
      required this.tel,
      required this.salt});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    tel = json['tel'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['tel'] = this.tel;
    data['salt'] = this.salt;
    return data;
  }
}
