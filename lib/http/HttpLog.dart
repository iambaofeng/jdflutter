import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/http/app_exceptions.dart';

class HttpLog extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options) {
    print("请求baseUrl：${options.baseUrl}");
    print("请求url：${options.path}");
    print('请求头: ' + options.headers.toString());
    if (options.data != null) {
      print('请求参数: ' + options.data.toString());
    }
    if (options.queryParameters != null) {
      print('请求参数：' + options.queryParameters.toString());
    }
    return super.onRequest(options);
  }

  @override
  Future<dynamic> onResponse(Response response) {
    if (response != null) {
      var responseStr = response.toString();
    }

    return super.onResponse(response); // continue
  }

  @override
  Future<dynamic> onError(DioError err) {
    //error统一处理
    AppException appException = AppException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    err.error = appException;

    print('请求异常: ' + err.toString());
    // print('请求异常信息: ' + err.response?.toString() ?? "");
    return super.onError(err);
  }
}
