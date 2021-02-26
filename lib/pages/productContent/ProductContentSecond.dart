import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../ProductContent.dart';

class ProductContentSecond extends StatelessWidget {
  ProductContentSecondController vm = Get.put(ProductContentSecondController());

  var _id;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: InAppWebView(initialUrl: vm._url),
          )
        ],
      ),
    );
  }
}

class ProductContentSecondController extends GetxController {
  ProductContentController father = Get.find();
  var _id;
  String _url = '';
  @override
  void onInit() {
    // TODO: implement onInit
    _id = father.productContentData.value.sId;
    print(_id);
    _url = 'http://jd.itying.com/pcontent?id=${this._id}';
    print(_url);
    super.onInit();
  }
}
