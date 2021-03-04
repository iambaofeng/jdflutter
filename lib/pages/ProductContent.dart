import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';
import 'package:flutter_jdshop/pages/productContent/ProductContentFirst.dart';
import 'package:flutter_jdshop/pages/productContent/ProductContentSecond.dart';
import 'package:flutter_jdshop/pages/productContent/ProductContentThird.dart';
import 'package:flutter_jdshop/pages/tabs/Cart.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:flutter_jdshop/widgets/JDButtonWidget.dart';
import 'package:flutter_jdshop/widgets/LoadingWidget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ProductContentPage extends StatelessWidget {
  ProductContentController vm = Get.put(ProductContentController());
  CartServices cartServices = Get.find();
  CartPageController cartPageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: setWidth(400),
                    child: TabBar(
                      indicatorColor: Colors.red,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          child: Text('商品'),
                        ),
                        Tab(
                          child: Text('详情'),
                        ),
                        Tab(
                          child: Text('评价'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                              setWidth(600), setHeight(100), 10, 0),
                          items: [
                            PopupMenuItem(
                                child: Row(
                              children: [Icon(Icons.home), Text('首页')],
                            )),
                            PopupMenuItem(
                                child: Row(
                              children: [Icon(Icons.search), Text('搜索')],
                            )),
                          ]);
                    })
              ],
            ),
            body: Obx(() {
              if (vm.productContentData.value.sId != null) {
                return Stack(
                  children: [
                    TabBarView(
                      children: [
                        ProductContentFirst(),
                        ProductContentSecond(),
                        ProductContentThird()
                      ],
                    ),
                    Positioned(
                        width: setWidth(750),
                        height: setHeight(120),
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.black12, width: 1))),
                          // color: Colors.red,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed('cart');
                                  cartPageController.isEdit.value = false;
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: setHeight(5)),
                                  width: setWidth(100),
                                  height: setHeight(88),
                                  child: Column(
                                    children: [
                                      Icon(Icons.shopping_cart),
                                      Text(
                                        '购物车',
                                        style: TextStyle(
                                            fontSize: setFontSize(20)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: JdButton(
                                    color: Color.fromRGBO(253, 1, 0, 0.9),
                                    cb: () {
                                      if (vm.productContentData.value.attr
                                              .length >
                                          0) {
                                        cartServices.productAttrBottomSheet
                                            .value = true;
                                      } else {
                                        cartServices.addCart(
                                            vm.productContentData.value);
                                        SmartDialog.showToast('加入购物车成功',
                                            alignment: Alignment.center);
                                        // print('无属性');
                                      }
                                    },
                                    text: '加入购物车',
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: JdButton(
                                    color: Color.fromRGBO(255, 165, 0, 0.9),
                                    cb: () {
                                      if (vm.productContentData.value.attr
                                              .length >
                                          0) {
                                        cartServices.productAttrBottomSheet
                                            .value = true;
                                      } else {
                                        print('无属性');
                                      }
                                    },
                                    text: '立即购买',
                                  )),
                            ],
                          ),
                        ))
                  ],
                );
              } else {
                return LoadingWidget();
                // return Container();
              }
            })));
  }
}

class ProductContentController extends GetxController {
  String _id = '';
  final productContentData = ProductContentItem().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    _id = Get.arguments['id'];
    _getContentData();
    super.onInit();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${this._id}';

    print(api);
    var res = await Dio().get(api);

    // print(res.data);
    var result = (ProductContentModel.fromJson(res.data).result);
    result.pic = Config.domain + result.pic.replaceAll('\\', '/');
    print(result.pic);
    print(result.title);
    print(result.subTitle);
    productContentData(result);
  }
}
