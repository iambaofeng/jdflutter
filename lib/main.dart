import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ServicesBind.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import './routers/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  await initServices();

  /// 等待服务初始化.
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  MyAppController vm = Get.put(MyAppController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //设计稿的宽度和高度
      //是否随系统字体缩放

      designSize: Size(750, 1334),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
          // smartManagement: SmartManagement.keepFactory,
          initialRoute: '/orderInfo',
          getPages: routes,
          theme: ThemeData(primaryColor: Colors.white),
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget child) {
            return FlutterSmartDialog(child: child);
          },
          initialBinding: ServicesBind()),
    );
  }
}

class MyAppController extends GetxController {
  var title = 'jdshop'.obs;
  var body = '我是首页'.obs;
}

/// 在你运行Flutter应用之前，让你的服务初始化是一个明智之举。
////因为你可以控制执行流程（也许你需要加载一些主题配置，apiKey，由用户自定义的语言等，所以在运行ApiService之前加载SettingService。
///所以GetMaterialApp()不需要重建，可以直接取值。
initServices() async {
  print('starting services ...');

  ///这里是你放get_storage、hive、shared_pref初始化的地方。
  ///或者moor连接，或者其他什么异步的东西。
  await Get.putAsync(() => DbService().init());
  await Get.putAsync(() => SettingsService().init());
  print('All services started...');
}

class DbService extends GetxService {
  Future<DbService> init() async {
    print('$runtimeType delays 2 sec');
    await 0.1.delay();
    print('$runtimeType ready!');
    return this;
  }
}

class SettingsService extends GetxService {
  Future init() async {
    print('$runtimeType delays 1 sec');
    await 0.2.delay();
    print('$runtimeType ready!');
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  }
}
