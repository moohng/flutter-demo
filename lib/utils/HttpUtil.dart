import 'package:dio/dio.dart';
// import 'dart:async';


class HttpUtil {
  // 全局定义
  static Dio dio;

  // 默认 options
  static const String BASE_URL = 'http://www.baidu.com/';
  static const int CONNECT_TIMEOUT = 20000;
  static const int RECEIVE_TIMEOUT = 5000;

  static Dio createInstance() {
    if (dio == null) {
      // 初始设置
      BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      dio = Dio(options);
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

  static Future get(String path, { Options options, Map<String, dynamic> queryParameters, CancelToken cancelToken, void Function(int, int) onReceiveProgress }) {
    Dio dio = createInstance();
    return dio.get(path, options: options, queryParameters: queryParameters, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
  }

  static clear() {
    dio = null;
  }
}
