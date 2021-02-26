class CatModel {
  List<CatItemModel> result;

  CatModel({this.result});

  CatModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<CatItemModel>();
      json['result'].forEach((v) {
        result.add(new CatItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CatItemModel {
  String sId;
  String title;
  Object status;
  String pic;
  String pid;
  String sort;

  CatItemModel(
      {this.sId, this.title, this.status, this.pic, this.pid, this.sort});

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