class CatProductModel {
  late String sId;
  late String title;
  late String pic;
  late double price;
  late String selectedAttr;
  late int count;
  late bool checked;
  CatProductModel(
      {this.sId = '',
      this.title = '',
      this.pic = '',
      this.price = 0.0,
      this.selectedAttr = '',
      this.checked = false,
      this.count = 0});

  CatProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    pic = json['pic'];
    if (json['price'] is int || json['price'] is double) {
      price = json['price'].toDouble();
    } else {
      price = double.parse(json['price']);
    }
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
