import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/http/AuthInterceptor.dart';
import 'package:flutter_jdshop/http/HttpLog.dart';
import 'package:flutter_jdshop/http/Proxy.dart';
import 'package:flutter_jdshop/http/ResponseInterceptors.dart';

class Http {
  //超时时间
  static const int _CONNECTTIMEOUT = 5000;
  static const int _RECEIVETIMEOUT = 3000;

  //单例模式
  static final Http _instance = Http._init();
  factory Http() => _instance;
  late Dio _dio;
  late BaseOptions _options;

  // //单例模式，只创建一次实例
  // static Http getInstance() {
  //   if (null == _instance) {
  //     _instance = new Http();
  //   }
  //   return _instance!;
  // }

  //构造函数
  Http._init() {
    _options = new BaseOptions(
        baseUrl: Config.BASE_URL,
        //连接时间为5秒
        connectTimeout: _CONNECTTIMEOUT,
        //响应时间为3秒
        receiveTimeout: _RECEIVETIMEOUT,
        //设置请求头
        headers: {"resource": "android"},
        //默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: Headers.formUrlEncodedContentType,
        //共有三种方式json,bytes(响应字节),stream（响应流）,plain
        responseType: ResponseType.json);
    _dio = new Dio(_options);
    //设置Cookie
    _dio.interceptors.add(CookieManager(CookieJar()));

    //添加日志拦截器
    _dio.interceptors.add(HttpLog());

    //添加请求头拦截器
    _dio.interceptors.add(AuthInterceptor());

    //添加返回拦截器
    _dio.interceptors.add(ResponseInterceptors());

    //是否启用代理
    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (Proxy.PROXY_ENABLE) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY $Proxy.PROXY_IP:$Proxy.PROXY_PORT";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  //get请求方法
  get(url, {data, options, cancelToken}) async {
    late Response response;
    try {
      response = await _dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('getHttp response: ${response.data}');
    } on DioError catch (e) {
      print('getHttp exception: $e');
      formatError(e);
    }
    return response.data;
  }

  //post请求
  post(url, {data, options, cancelToken}) async {
    late Response response;
    try {
      response = await _dio.post(url,
          data: data, options: options, cancelToken: cancelToken);
      print('postHttp response: ${response.data}');
    } on DioError catch (e) {
      print('postHttp exception: $e');
      formatError(e);
    }
    return response.data;
  }

  //post Form请求
  postForm(url, {data, options, cancelToken}) async {
    late Response response;
    try {
      response = await _dio.post(url,
          options: options, cancelToken: cancelToken, data: data);
      print('postHttp response: ${response.data}');
    } on DioError catch (e) {
      print('postHttp exception: $e');
      formatError(e);
    }
    return response.data;
  }

  //下载文件
  downLoadFile(urlPath, savePath) async {
    late Response response;
    try {
      response = await _dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        print('$count $total');
      });
      print('downLoadFile response: ${response.data}');
    } on DioError catch (e) {
      print('downLoadFile exception: $e');
      formatError(e);
    }
    return response.data;
  }

  //取消请求
  cancleRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }
}
