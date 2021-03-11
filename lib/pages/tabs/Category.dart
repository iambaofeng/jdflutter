import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/CatModel.dart';
import 'package:flutter_jdshop/widgets/AppbarWidget.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  CategoryPageController vm =
      Get.put(CategoryPageController(), permanent: false);

  Widget _leftCateWidget(leftWidth) {
    return Container(
      width: leftWidth,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  vm.handleLeftListTap(index, vm.leftCateList[index].sId);
                },
                child: Container(
                    width: double.infinity,
                    height: setHeight(84),
                    padding: EdgeInsets.only(top: setHeight(24)),
                    color: vm.selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                    child: Text(
                      '第${vm.leftCateList[index].title}',
                      textAlign: TextAlign.center,
                    )),
              ),
              Divider(
                height: setHeight(1),
              )
            ],
          );
        },
        itemCount: vm.leftCateList.length,
      ),
      height: getScreenHeight(),
      // color: Colors.red,
    );
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(setWidth(10)),
      height: getScreenHeight(),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: rightItemWidth / rightItemHeight,
              crossAxisCount: 3,
              crossAxisSpacing: setWidth(10),
              mainAxisSpacing: setWidth(10)),
          itemCount: vm.rightCateList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed('/productList',
                    arguments: {'cid': vm.rightCateList[index].sId});
              },
              child: Container(
                // padding: EdgeInsets.all(setWidth(20)),
                child: Column(
                  children: [
                    AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Obx(
                          () => Image.network(
                            vm.rightCateList[index].pic,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Container(
                      height: setHeight(28),
                      child: Text(
                        vm.rightCateList[index].title,
                        style: TextStyle(fontSize: setFontSize(16)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      color: Color.fromRGBO(240, 246, 246, 0.9),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //左侧侧边栏宽度
    var leftWidth = getScreenWidth() / 4;

    //右侧每一个宫格的宽度
    var rightItemWidth = (getScreenWidth() - leftWidth - setWidth(40)) / 3;
    var rightItemHeight = rightItemWidth + setHeight(28);

    return Scaffold(
        appBar: searchAppBar(),
        body: Obx(() => Row(
              children: [
                vm.leftCateList.isNotEmpty
                    ? _leftCateWidget(leftWidth)
                    : Container(
                        width: leftWidth,
                      ),
                vm.leftCateList.isNotEmpty
                    ? _rightCateWidget(rightItemWidth, rightItemHeight)
                    : Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(setWidth(10)),
                          height: getScreenHeight(),
                          color: Color.fromRGBO(240, 246, 246, 0.9),
                          child: Text('加载中...'),
                        ),
                      )
              ],
            )));
  }
}

class CategoryPageController extends GetxController {
  var selectIndex = 0.obs;

  void handleLeftListTap(index, id) {
    selectIndex.value = index;
    _getRightCateData(id);
  }

  final leftCateList = <CatItemModel>[].obs;
  final rightCateList = <CatItemModel>[].obs;

  void _getLeftCateData() async {
    var api = '${Config.BASE_URL}api/pcate';
    var res = await Dio().get(api);
    print(res.data);
    var result = CatModel.fromJson(res.data).result;

    // result.forEach((element) {
    //   var str = element.sPic;
    //   element.sPic = Config.domain + str.replaceAll('\\', '/');
    //   print(element.sPic);
    // });
    leftCateList.clear();
    leftCateList.addAll(result);
    _getRightCateData(leftCateList[0].sId);
  }

  _getRightCateData(pid) async {
    var api = '${Config.BASE_URL}api/pcate?pid=${pid}';
    var res = await Dio().get(api);
    print(res.data);
    var result = CatModel.fromJson(res.data).result;

    result.forEach((element) {
      var str = element.pic;
      element.pic = Config.BASE_URL + str.replaceAll('\\', '/');
    });

    rightCateList.clear();
    rightCateList.addAll(result);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getLeftCateData();
  }
}
