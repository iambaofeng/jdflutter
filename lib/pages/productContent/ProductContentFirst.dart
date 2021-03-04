import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';
import 'package:flutter_jdshop/pages/ProductContent.dart';
import 'package:flutter_jdshop/pages/productContent/CartNumber.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ProductContentFirst extends StatelessWidget {
  ProductContentFirstController vm = Get.put(ProductContentFirstController());
  ProductContentController father = Get.find();
  CartServices cartServices = Get.find();
  ProductContentFirst() {
    ever(cartServices.productAttrBottomSheet, (value) {
      _showBottomSheet(value);
    });
  }

  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];

    vm.dataList.forEach((element) {
      List<Widget> list = [];
      element.attrlist.forEach((item) {
        list.add(Container(
          margin: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              vm._changeAttr(element.attrlist, item);
            },
            child: Chip(
              padding: EdgeInsets.all(10),
              label: Text(
                item.value.title,
                style: TextStyle(
                    color: item.value.checked ? Colors.white : Colors.black54),
              ),
              backgroundColor: item.value.checked ? Colors.red : Colors.black26,
            ),
          ),
        ));
      });
      attrList.add(Wrap(
        children: [
          Container(
            width: setWidth(110),
            child: Padding(
              padding: EdgeInsets.only(top: setHeight(30)),
              child: Text(
                "${element.cate}:",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: setFontSize(20)),
              ),
            ),
          ),
          Container(
            width: setWidth(600),
            child: Wrap(children: list),
          )
        ],
      ));
    });
    return attrList;
  }

  _showBottomSheet(value) {
    if (value) {
      _attrBottomSheet();
    }
  }

  _attrBottomSheet() {
    SmartDialog.show(
      alignmentTemp: Alignment.bottomCenter,
      widget: Container(
          height: setHeight(700),
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(setWidth(20)),
                child: _getAttrWidget().length > 0
                    ? ListView(
                        children: [
                          Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _getAttrWidget())),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(top: setHeight(10)),
                            height: setHeight(100),
                            child: Row(
                              children: [
                                Text('数量：'),
                                SizedBox(width: 10),
                                ProductContentCartNumber()
                              ],
                            ),
                          )
                        ],
                      )
                    : Container(
                        height: setHeight(300),
                        child: Center(
                          child: Text('无属性'),
                        ),
                      ),
              ),
              SizedBox(
                height: setHeight(120),
              ),
              Positioned(
                width: setWidth(750),
                height: setHeight(120),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(setWidth(10), 0, 0, 0),
                          child: JdButton(
                            color: Color.fromRGBO(253, 1, 0, 0.9),
                            cb: () {
                              cartServices
                                  .addCart(father.productContentData.value);
                              vm._getSelectedAttrValue();
                              SmartDialog.dismiss();
                              SmartDialog.showToast('加入购物车成功',
                                  alignment: Alignment.center);
                            },
                            text: '加入购物车',
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: JdButton(
                            color: Color.fromRGBO(255, 165, 0, 0.9),
                            cb: () {
                              print('456');
                            },
                            text: '立即购买',
                          ),
                        )),
                  ],
                ),
                bottom: 0,
              )
            ],
          )),
    ).then((value) {
      cartServices.productAttrBottomSheet.value = false;
      // Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get.bottomSheet(c)

    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(father.productContentData.value.pic),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                father.productContentData.value.title,
                style:
                    TextStyle(color: Colors.black87, fontSize: setFontSize(36)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                father.productContentData.value.subTitle == null
                    ? '没有副标题'
                    : father.productContentData.value.subTitle,
                style:
                    TextStyle(color: Colors.black45, fontSize: setFontSize(28)),
              ),
            ),
            //价格
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text('特价：'),
                          Text(
                            '￥${father.productContentData.value.price}',
                            style: TextStyle(
                                color: Colors.red, fontSize: setFontSize(46)),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('原价：'),
                          Text(
                            '￥${father.productContentData.value.oldPrice}',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: setFontSize(28),
                                decoration: TextDecoration.lineThrough),
                          )
                        ],
                      ))
                ],
              ),
            ),
            //筛选
            vm.dataList.length > 0
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    height: setHeight(80),
                    child: InkWell(
                      onTap: () {
                        cartServices.productAttrBottomSheet.value = true;
                      },
                      child: Row(
                        children: [
                          Text(
                            '已选:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Obx(() => Text("${vm._title}1件"))
                        ],
                      ),
                    ),
                  )
                : Text(''),
            Divider(),
            Container(
              height: setHeight(80),
              child: Row(
                children: [
                  Text(
                    '运费:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("免运费")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductContentFirstController extends GetxController {
  ProductContentController father = Get.find();
  CartServices cartController = Get.find();
  var dataList = [];
  final _title = ''.obs;
  _changeAttr(attr, item) {
    attr.forEach((element) {
      element.value.checked = false;
    });

    item(ProductAttrItem(title: item.value.title, checked: true));
    _getSelectedAttrValue();
  }

  _getSelectedAttrValue() {
    var list = [];
    dataList.forEach((element) {
      print(element);
      element.attrlist.forEach((item) {
        if (item.value.checked) {
          list.add(item.value.title);
        }
      });
    });
    _title.value = list.join('，');
    father.productContentData.update((val) {
      val.selectedAttr = _title.value;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    dataList = father.productContentData.value.attr ?? [];
    //商品属性默认选第一个
    dataList.forEach((element) {
      element.attrlist[0].value.checked = true;
    });
    super.onInit();
  }
}
