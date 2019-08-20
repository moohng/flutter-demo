import 'package:dio/dio.dart';
// import 'dart:async';


class HttpUtil {
  // 全局定义
  static Dio dio;

  static Dio createInstance() {
    if (dio == null) {
      dio = Dio();
      // 请求拦截器
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          return options;
        },
        onResponse: (Response response) {
          return response;
        },
        onError: (DioError err) {
          return err;
        },
      ));
    }
    return dio;
  }

  static clear() {
    dio = null;
  }
}
