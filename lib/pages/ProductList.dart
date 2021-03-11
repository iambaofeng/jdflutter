import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/CatModel.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import 'package:flutter_jdshop/services/SearchServices.dart';
import 'package:flutter_jdshop/widgets/AppbarWidget.dart';
import 'package:flutter_jdshop/widgets/LoadingWidget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProductListPage extends StatelessWidget {
  ProductListPageController vm = Get.put(ProductListPageController());

  //列表状态
  Widget _showMore(index) {
    if (vm._hasMore.value) {
      if (index == vm._productList.length - 1) {
        return LoadingWidget();
      } else {
        return Text('');
      }
    } else {
      return (index == vm._productList.length - 1) ? Text('我是有底线的') : Text('');
    }
  }

  //商品列表
  Widget _productListWidget() {
    if (vm._productList.length > 0) {
      return Container(
          padding: EdgeInsets.all(setWidth(10)),
          margin: EdgeInsets.only(top: setHeight(80)),
          child: ListView.builder(
            controller: vm._scrollController,
            itemBuilder: (conext, index) {
              return Column(children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/productContent',
                        arguments: {'id': vm._productList[index].sId});
                  },
                  child: Row(
                    children: [
                      Container(
                        width: setWidth(180),
                        height: setWidth(180),
                        child: Image.network(
                          vm._productList[index].sPic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: setWidth(10)),
                            height: setWidth(180),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vm._productList[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: setHeight(36),
                                      margin:
                                          EdgeInsets.only(right: setWidth(10)),
                                      padding: EdgeInsets.fromLTRB(
                                          setWidth(10), 0, setWidth(10), 0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(setWidth(10)),
                                        color:
                                            Color.fromRGBO(230, 230, 230, 0.9),
                                      ),
                                      child: Text('4g'),
                                    ),
                                    Container(
                                      height: setHeight(36),
                                      margin:
                                          EdgeInsets.only(right: setWidth(10)),
                                      padding: EdgeInsets.fromLTRB(
                                          setWidth(10), 0, setWidth(10), 0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(setWidth(10)),
                                        color:
                                            Color.fromRGBO(230, 230, 230, 0.9),
                                      ),
                                      child: Text('128g'),
                                    )
                                  ],
                                ),
                                Text(
                                  '￥${vm._productList[index].price.toString()}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: setFontSize(26)),
                                )
                              ],
                            ),
                            // color: Colors.red,
                          ))
                    ],
                  ),
                ),
                Divider(
                  height: setWidth(20),
                ),
                _showMore(index)
              ]);
            },
            itemCount: vm._productList.length,
          ));
    } else {
      return LoadingWidget();
    }
  }

  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (vm._subHeaderList[id - 1]['sort'] == 1) {
        return Icon(Icons.arrow_drop_down);
      } else {
        return Icon(Icons.arrow_drop_up);
      }
    } else {
      return Text('');
    }
  }

  //筛选导航

  Widget _subHeaderWidget() {
    return Positioned(
        top: 0,
        height: setHeight(80),
        width: getScreenWidth(),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
                color: Color.fromRGBO(233, 233, 233, 0.9), width: setWidth(2)),
          )),
          // color: Colors.red,
          child: Row(
            children: vm._subHeaderList.map((value) {
              return Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      vm._subHeaderChange(value['id']);
                    },
                    child: Obx(() => Container(
                          padding: EdgeInsets.fromLTRB(
                              0, setHeight(16), 0, setHeight(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                value['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:
                                        value['id'] == vm._selectHeaderId.value
                                            ? Colors.red
                                            : Colors.black),
                              ),
                              _showIcon(value['id'])
                            ],
                          ),
                        )),
                  ));
            }).toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: vm._scaffoldkey,
        appBar: AppBar(
          leading: BackButton(),
          title: Container(
            height: setHeight(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
              ),
              controller: vm._initKeywordController,
              onChanged: (value) {
                vm._keywords = value;
              },
            ),
          ),
          actions: [
            Container(
              height: setHeight(68),
              width: setWidth(80),
              child: Row(
                children: [
                  InkWell(
                    child: Text('搜索'),
                    onTap: () {
                      SearchServices.setSearchData(vm._keywords);
                      vm._cid = null;
                      vm._page = 1;
                      vm._productList.clear();
                      vm._getProductListData();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            child: Text('实现筛选'),
          ),
        ),
        body: Obx(() => vm._hasData.value
            ? Stack(
                children: [Obx(() => _productListWidget()), _subHeaderWidget()],
              )
            : Center(
                child: Text('没有您要浏览的数据'),
              )));
  }
}

class ProductListPageController extends GetxController {
  int _page = 1;
  int _pageSize = 10;
  final _productList = <ProductItemModel>[].obs;
  bool _flag = true;
  List _subHeaderList = [
    {'id': 1, "title": "综合", "fileds": 'all', "sort": -1}.obs,
    {'id': 2, "title": "销量", "fileds": 'salecount', "sort": -1}.obs,
    {'id': 3, "title": "价格", "fileds": 'price', "sort": -1}.obs,
    {
      'id': 4,
      "title": "筛选",
    }.obs
  ].obs;
  final _selectHeaderId = 1.obs;
  final _hasMore = true.obs;
  final _hasData = true.obs;
  String _sort = '';
  String _keywords = '';
  var _cid = null;
  //排序
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  TextEditingController _initKeywordController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    if (Get.arguments['search'] != null) {
      _initKeywordController.text = Get.arguments['search'];
      _keywords = Get.arguments['search'];
    }
    if (Get.arguments['cid'] != null) {
      _cid = Get.arguments['cid'];
    }
    print(_subHeaderList);
    _getProductListData();

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      // _scrollController.position.pixels//滚动条高度
      // _scrollController.position.maxScrollExtent//获取页面高度
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (_flag && _hasMore.value) {
          _getProductListData();
        }

        // print(_page);
      } else {
        // print('滚动了');
      }
    });
    super.onInit();
  }

  //切换二级菜单方法
  void _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldkey.currentState?.openEndDrawer();
      _selectHeaderId.value = id;
    } else {
      _selectHeaderId.value = id;

      _sort =
          "${this._subHeaderList[id - 1]['fileds']}_${this._subHeaderList[id - 1]['sort']}";

      _subHeaderList[id - 1]['sort'] = _subHeaderList[id - 1]['sort'] * -1;
      print(_subHeaderList[id - 1]['sort']);

      //重置分页数
      _page = 1;

      //重置数据
      _productList.clear();

      //滚动条回到顶部
      _scrollController.jumpTo(0);

      //重置hasmore
      _hasMore.value = true;

      //重新请求数据
      _getProductListData();
    }
  }

  //获取商品列表方法
  void _getProductListData() async {
    _flag = false;
    var api = '';
    if (_cid != null) {
      api =
          '${Config.domain}api/plist?cid=${this._cid}&page=${this._page}&pageSize=${this._pageSize}';
    } else {
      api =
          '${Config.domain}api/plist?page=${this._page}&pageSize=${this._pageSize}&search=${this._keywords}';
    }

    print(api);
    var res = await Dio().get(api);

    // print(res.data);
    var result = ProductModel.fromJson(res.data).result;

    result.forEach((element) {
      var str = element.sPic;
      element.sPic = Config.domain + str.replaceAll('\\', '/');
      // print(element.sPic);
    });

    // _productList.clear();
    _productList.addAll(result);
    _page++;
    _flag = true;
    if (result.length < _pageSize) {
      _hasMore.value = false;
    }
    if (_productList.length == 0) {
      _hasData.value = false;
    } else {
      _hasData.value = true;
    }

    // print(_productList.length);
  }
}
