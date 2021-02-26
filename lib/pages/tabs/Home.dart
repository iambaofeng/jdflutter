import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/FocusModel.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import 'package:flutter_jdshop/services/SearchServices.dart';
import 'package:flutter_jdshop/widgets/AppbarWidget.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  HomePageController vm = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  final HomePageController vm = Get.find();
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchAppBar(),
        body: Container(
            child: Obx(() => ListView(
                  children: [
                    _buildSwiper(),
                    SizedBox(
                      height: setHeight(20),
                    ),
                    _buildTitle('猜你喜欢'),
                    SizedBox(
                      height: setHeight(20),
                    ),
                    _buildGuessYouLikeListView(),
                    _buildTitle('热门推荐'),
                    _buildHotProductWarp()
                  ],
                ))));
  }

  //热门推荐
  Widget _buildHotProductWarp() {
    var warpItemWidth = (setWidth(getScreenWidth()) - setWidth(30)) / 2;

    List<Widget> gethotlist() {
      if (vm.hotproductList.length > 0) {
        return vm.hotproductList.map((element) {
          return InkWell(
            child: Container(
              padding: EdgeInsets.all(setWidth(20)),
              width: warpItemWidth,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
              child: Column(
                children: [
                  Container(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        element.sPic,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: setHeight(20)),
                    child: Text(
                      element.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: setHeight(20)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '￥${element.price.toString()}',
                            style: TextStyle(
                                color: Colors.red, fontSize: setFontSize(16)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "￥${element.oldPrice}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: setFontSize(14),
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.toNamed('/productContent', arguments: {'id': element.sId});
            },
          );
        }).toList();
      } else {
        return [];
      }
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: gethotlist(),
      ),
    );
  }

  //猜你喜欢
  Widget _buildGuessYouLikeListView() {
    if (vm.gussproductList.length > 0) {
      return Container(
        padding: EdgeInsets.all(setWidth(20)),
        height: setHeight(234),
        width: double.infinity,
        child: ListView.builder(
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(right: setWidth(20)),
                  child: Image.network(
                    vm.gussproductList[index].sPic,
                    fit: BoxFit.cover,
                    height: setHeight(140),
                    width: setWidth(140),
                  ),
                ),
                Container(
                  height: setHeight(44),
                  padding: EdgeInsets.only(top: setWidth(10)),
                  child: Text(
                    '￥${vm.gussproductList[index].price}',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: 10,
        ),
      );
    } else {
      return Text('加载中...');
    }
  }

  //广告
  Widget _buildSwiper() {
    if (vm.imgList.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          //Swiper的父容器必须要已知宽高
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                vm.imgList[index].pic,
                fit: BoxFit.fill,
              );
            },
            itemCount: vm.imgList.length,
            pagination: SwiperPagination(),
            // control: SwiperControl(),
          ),
        ),
      );
    } else {
      return Text('加载中');
    }
  }

  //标题
  Widget _buildTitle(value) {
    return Container(
      height: setHeight(32),
      margin: EdgeInsets.fromLTRB(setWidth(20), 0, 0, 0),
      padding: EdgeInsets.fromLTRB(setWidth(20), 0, 0, 0),
      decoration: BoxDecoration(
          border:
              Border(left: BorderSide(color: Colors.red, width: setWidth(10)))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}

class HomePageController extends GetxController {
  var imgList = <FocusItemModel>[].obs;
  var gussproductList = <ProductItemModel>[].obs;
  var hotproductList = <ProductItemModel>[].obs;
  var focusData = [].obs;

  //获取轮播图
  void _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var res = await Dio().get(api);
    var result = FocusModel.fromJson(res.data).result;
    result.forEach((element) {
      var str = element.pic;
      element.pic = Config.domain + str.replaceAll('\\', '/');
      print(element.pic);
    });
    imgList.clear();

    imgList.addAll(result);
    // print(focusData.data is Map);
  }

  //获取猜你喜欢
  _getGuessYouLikeData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var res = await Dio().get(api);
    var result = ProductModel.fromJson(res.data).result;

    result.forEach((element) {
      var str = element.sPic;
      element.sPic = Config.domain + str.replaceAll('\\', '/');
    });
    gussproductList.clear();
    gussproductList.addAll(result);
  }

  //获取热门推荐
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var res = await Dio().get(api);
    var result = ProductModel.fromJson(res.data).result;

    result.forEach((element) {
      var str = element.sPic;
      element.sPic = Config.domain + str.replaceAll('\\', '/');
    });
    hotproductList.clear();
    hotproductList.addAll(result);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SearchServices.setSearchData('aaa');
    _getFocusData();
    _getGuessYouLikeData();
    _getHotProductData();
  }
}
