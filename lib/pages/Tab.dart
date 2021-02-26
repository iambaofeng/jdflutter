import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';
import '../pages/tabs/Category.dart';
import '../pages/tabs/Home.dart';
import '../pages/tabs/People.dart';
import '../pages/tabs/Cart.dart';

class Tabs extends StatelessWidget {
  TabsController vm = Get.put(TabsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
          controller: vm._pageController,
          itemBuilder: (context, index) {
            return vm.pageList[index];
          },
          onPageChanged: (index) {
            vm.currentIndex.value = index;
          },
          // physics: NeverScrollableScrollPhysics(), //禁止左滑
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            //当前索引
            currentIndex: vm.currentIndex.value,
            //底部菜单栏的类型（必选fixed）
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.red,
            //选中tab页签的方法
            onTap: vm.changeCurrentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: '购物车'),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
            ],
          ),
        ));
  }
}

class TabsController extends GetxController {
  var title = 'jdshop'.obs;
  var currentIndex = 0.obs;
  PageController _pageController;
  List pageList = [HomePage(), CategoryPage(), CartPage(), PeoplePage()];

  void changeCurrentIndex(index) {
    currentIndex.value = index;
    _pageController.jumpToPage(index);
  }

  changeName() {}
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _pageController = PageController(initialPage: currentIndex.value);
  }
}
