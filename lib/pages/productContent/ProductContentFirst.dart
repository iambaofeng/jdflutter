import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/pages/ProductContent.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:get/get.dart';

class ProductContentFirst extends StatelessWidget {
  ProductContentFirstController vm = Get.put(ProductContentFirstController());
  ProductContentController father = Get.find();

  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];

    vm._attr.forEach((element) {
      List<Widget> list = [];
      element.list.forEach((item) {
        list.add(Container(
          margin: EdgeInsets.all(10),
          child: Chip(padding: EdgeInsets.all(10), label: Text(item)),
        ));
      });
      attrList.add(Wrap(
        children: [
          Container(
            width: setWidth(100),
            child: Padding(
              padding: EdgeInsets.only(top: setWidth(22)),
              child: Text(
                element.cate,
                style: TextStyle(fontWeight: FontWeight.bold),
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

  @override
  Widget build(BuildContext context) {
    _attrBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                return false;
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(setWidth(20)),
                    child: ListView(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _getAttrWidget())
                      ],
                    ),
                  ),
                  Positioned(
                    width: setWidth(750),
                    height: setHeight(76),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: JdButton(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                cb: () {
                                  print('123');
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
              ),
            );
          });
    }

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
            Container(
              margin: EdgeInsets.only(top: 10),
              height: setHeight(80),
              child: InkWell(
                onTap: () {
                  _attrBottomSheet();
                },
                child: Row(
                  children: [
                    Text(
                      '已选:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("115，黑色，XL，1件")
                  ],
                ),
              ),
            ),
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

  final _attr = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    _attr(father.productContentData.value.attr);
    // print(_attr.value[0].list);
    super.onInit();
  }
}
