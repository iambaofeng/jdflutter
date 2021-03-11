import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductContentModel {
  ProductContentItem result = ProductContentItem(
      attr: [],
      sId: "",
      title: "",
      price: 0,
      oldPrice: "",
      isBest: "",
      isHot: "",
      isNew: "",
      content: '',
      status: "",
      subTitle: "",
      salecount: 0,
      selectedAttr: "",
      count: 0,
      checked: false,
      cname: '',
      cid: "",
      pic: "");

  ProductContentModel({required this.result});

  ProductContentModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new ProductContentItem.fromJson(json['result'])
        : ProductContentItem(
            attr: [],
            sId: "",
            title: "",
            price: 0,
            oldPrice: "",
            isBest: "",
            isHot: "",
            isNew: "",
            content: '',
            status: "",
            subTitle: "",
            salecount: 0,
            selectedAttr: "",
            count: 0,
            checked: false,
            cname: '',
            cid: "",
            pic: "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result.toJson();
    return data;
  }
}

class ProductContentItem {
  late String sId;
  late String title;
  late String cid;
  late Object price;
  late String oldPrice;
  late Object isBest;
  late Object isHot;
  late Object isNew;
  late String status;
  late String pic;
  late String content;
  late String cname;
  late List<Attr> attr;
  late String subTitle;
  late int salecount;
  late int count;
  late String selectedAttr;
  late bool checked;
  ProductContentItem(
      {required this.sId,
      required this.title,
      required this.cid,
      required this.price,
      required this.oldPrice,
      required this.isBest,
      required this.isHot,
      required this.isNew,
      required this.status,
      required this.pic,
      required this.content,
      required this.cname,
      required this.attr,
      required this.subTitle,
      required this.salecount,
      required this.count,
      required this.checked,
      required this.selectedAttr});

  ProductContentItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    isBest = json['is_best'];
    isHot = json['is_hot'];
    isNew = json['is_new'];
    status = json['status'];
    pic = json['pic'];
    content = json['content'];
    cname = json['cname'];
    if (json['attr'] != null) {
      attr = <Attr>[];
      json['attr'].forEach((v) {
        attr.add(new Attr.fromJson(v));
      });
    }
    subTitle = json['sub_title'];
    salecount = json['salecount'];
    count = 1;
    selectedAttr = '';
    checked = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['is_best'] = this.isBest;
    data['is_hot'] = this.isHot;
    data['is_new'] = this.isNew;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['content'] = this.content;
    data['cname'] = this.cname;
    data['attr'] = this.attr.map((v) => v.toJson()).toList();
    data['sub_title'] = this.subTitle;
    data['salecount'] = this.salecount;
    return data;
  }
}

class ProductAttrItem {
  var title;
  var checked;
  ProductAttrItem({this.title, this.checked});
}

class Attr {
  late String cate;
  late List<String> list;
  late RxList attrlist;
  Attr({required this.cate, required this.list});

  Attr.fromJson(Map<String, dynamic> json) {
    cate = json['cate'];
    list = json['list'].cast<String>();
    attrlist = [].obs;
    list.forEach((element) {
      attrlist.add(ProductAttrItem(title: element, checked: false).obs);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate'] = this.cate;
    data['list'] = this.list;
    return data;
  }
}
