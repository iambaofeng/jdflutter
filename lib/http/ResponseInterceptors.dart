import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ResponseInterceptors extends Interceptor {
  @override
  Future<dynamic> onResponse(Response response) {
    RequestOptions option = response.request;
    if (response.statusCode == 200 || response.statusCode == 201) {
      //响应拦截器在这处理
    } else {
      SmartDialog.showToast(response.data["msg"]);
    }
    return super.onResponse(response);
  }
}

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;
}
