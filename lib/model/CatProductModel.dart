class CatProductModel {
  String sId;
  String title;
  String pic;
  Object price;
  String selectedAttr;
  int count;
  bool checked;
  CatProductModel(
      {this.sId,
      this.title,
      this.pic,
      this.price,
      this.selectedAttr,
      this.checked,
      this.count});

  CatProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    pic = json['pic'];
    price = json['price'];
    selectedAttr = json['selectedAttr'];
    count = json['count'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['pic'] = this.pic;
    data['price'] = this.price;
    data['selectedAttr'] = this.selectedAttr;
    data['count'] = this.count;
    data['checked'] = this.checked;
    return data;
  }
}
