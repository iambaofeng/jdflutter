import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/widgets/jdButtonWidget.dart';
import 'package:get/get.dart';

class ProductContentFirst extends StatelessWidget {
  ProductContentFirstController vm = Get.put(ProductContentFirstController());

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
                          children: [
                            Wrap(
                              children: [
                                Container(
                                  width: setWidth(100),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: setWidth(22)),
                                    child: Text(
                                      '颜色',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: setWidth(600),
                                  child: Wrap(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                            padding: EdgeInsets.all(10),
                                            label: Text('白色')),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                            padding: EdgeInsets.all(10),
                                            label: Text('白色')),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                            padding: EdgeInsets.all(10),
                                            label: Text('白色')),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                            padding: EdgeInsets.all(10),
                                            label: Text('白色')),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                            padding: EdgeInsets.all(10),
                                            label: Text('白色')),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                            padding: EdgeInsets.all(10),
                                            label: Text('白色')),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
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
              child:
                  Image.network("https://www.itying.com/images/flutter/p1.jpg"),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '联想ThinkPad 翼480 （0VCD）英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑',
                style:
                    TextStyle(color: Colors.black87, fontSize: setFontSize(36)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office',
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
                            '￥28',
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
                            '￥50',
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

class ProductContentFirstController extends GetxController {}
