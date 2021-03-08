class UserInfoModel {
  String sId;
  String username;
  String tel;
  String salt;

  UserInfoModel({this.sId, this.username, this.tel, this.salt});

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
