import 'package:flutter_jdshop/services/CartServices.dart';
import 'package:flutter_jdshop/services/SignServices.dart';
import 'package:flutter_jdshop/services/UserServices.dart';
import 'package:get/get.dart';

class ServicesBind implements Bindings {
  @override
  void dependencies() {
    //载入全局使用的Sercices
    //购物车服务

    Get.lazyPut<UserServices>(() => UserServices());
    Get.lazyPut<CartServices>(() => CartServices());
    Get.lazyPut<SignServices>(() => SignServices());
    // TODO: implement dependencies
  }
}
