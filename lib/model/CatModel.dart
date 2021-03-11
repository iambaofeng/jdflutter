class CatModel {
  List<CatItemModel> result = [];

  CatModel({required this.result});

  CatModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <CatItemModel>[];
      json['result'].forEach((v) {
        result.add(new CatItemModel.fromJson(v));
      });
    } else {
      result = <CatItemModel>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result.map((v) => v.toJson()).toList();
    return data;
  }
}

class CatItemModel {
  late String sId;
  late String title;
  late Object status;
  late String pic;
  late String pid;
  late String sort;

  CatItemModel(
      {this.sId = '',
      this.title = '',
      this.status = '',
      this.pic = '',
      this.pid = '',
      this.sort = ''});

  CatItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['pid'] = this.pid;
    data['sort'] = this.sort;
    return data;
  }
}
