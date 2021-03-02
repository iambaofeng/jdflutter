import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:get/get.dart';

class ServicesBind implements Bindings {
  @override
  void dependencies() {
    //载入全局使用的Sercices
    //购物车服务
    Get.lazyPut<CartController>(() => CartController());
    // TODO: implement dependencies
  }
}
