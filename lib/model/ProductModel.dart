class ProductModel {
  List<ProductItemModel> result = [];

  ProductModel({required this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      // result = <ProductItemModel>[];
      json['result'].forEach((v) {
        result.add(new ProductItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result.map((v) => v.toJson()).toList();
    return data;
  }
}

class ProductItemModel {
  late String sId;
  late String title;
  late String cid;
  late Object price; //所有的类型都继承 Object
  late String oldPrice;
  late String pic;
  late String sPic;

  ProductItemModel(
      {required this.sId,
      required this.title,
      required this.cid,
      required this.price,
      required this.oldPrice,
      required this.pic,
      required this.sPic});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['pic'] = this.pic;
    data['s_pic'] = this.sPic;
    return data;
  }
}
