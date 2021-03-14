import 'package:get/get.dart';

class OrderModel {
  late bool success;
  late String message;
  late RxList<Rx<OrderList>> result;

  OrderModel(
      {required this.success, required this.message, required this.result});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Rx<OrderList>>[].obs;
      json['result'].forEach((v) {
        result.add(OrderList.fromJson(v).obs);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['result'] = this.result.map((v) => v.toJson()).toList();
    return data;
  }
}

class OrderList {
  late String sId;
  late String uid;
  late String name;
  late String phone;
  late String address;
  late String allPrice;
  late int payStatus;
  late int orderStatus;
  late RxList<Rx<OrderItem>> orderItem;

  OrderList(
      {required this.sId,
      required this.uid,
      required this.name,
      required this.phone,
      required this.address,
      required this.allPrice,
      required this.payStatus,
      required this.orderStatus,
      required this.orderItem});

  OrderList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    allPrice = json['all_price'];
    payStatus = json['pay_status'];
    orderStatus = json['order_status'];
    if (json['order_item'] != null) {
      orderItem = <Rx<OrderItem>>[].obs;
      json['order_item'].forEach((v) {
        orderItem.add(new OrderItem.fromJson(v).obs);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['all_price'] = this.allPrice;
    data['pay_status'] = this.payStatus;
    data['order_status'] = this.orderStatus;
    data['order_item'] = this.orderItem.map((v) => v.toJson()).toList();
    return data;
  }
}

class OrderItem {
  late String sId;
  late String orderId;
  late String productTitle;
  late String productId;
  late int productPrice;
  late String productImg;
  late int productCount;
  late String selectedAttr;
  late int addTime;

  OrderItem(
      {required this.sId,
      required this.orderId,
      required this.productTitle,
      required this.productId,
      required this.productPrice,
      required this.productImg,
      required this.productCount,
      required this.selectedAttr,
      required this.addTime});

  OrderItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    productTitle = json['product_title'];
    productId = json['product_id'];
    productPrice = json['product_price'];
    productImg = json['product_img'];
    productCount = json['product_count'];
    selectedAttr = json['selected_attr'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['order_id'] = this.orderId;
    data['product_title'] = this.productTitle;
    data['product_id'] = this.productId;
    data['product_price'] = this.productPrice;
    data['product_img'] = this.productImg;
    data['product_count'] = this.productCount;
    data['selected_attr'] = this.selectedAttr;
    data['add_time'] = this.addTime;
    return data;
  }
}
