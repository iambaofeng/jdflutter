import 'package:dio/dio.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/services/Storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    String accessToken = await Storage.getString(Config.ACCESS_TOKEN);
    if (accessToken != '') {
      options.headers['content-type'] = 'application/json;charset=utf-8';
      options.headers['Authorization'] = 'JWT $accessToken';
    }
    return super.onRequest(options);
  }
}
