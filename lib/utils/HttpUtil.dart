import 'package:dio/dio.dart';
// import 'dart:async';


class HttpUtil {
  // 全局定义
  static Dio dio;

  // 默认 options
  static const String BASE_URL = 'http://192.168.0.119/';
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
          print('dio request >>> ${options.uri}');
          return options;
        },
        onResponse: (Response response) {
          print('dio response >>> $response');

          var result = response.data;
          if (result is String) {
            return dio.reject(result);
          }
          if (result['code'] != null && result['code'] != 0) {
            return dio.reject(result);
          }

          return dio.resolve(result);
        },
        onError: (DioError err) {
          print('dio error >>> ${err.message}');
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

  static Future post(String path, { dynamic data, Options options }) async {
    Dio dio = createInstance();
    Response<Map<String, dynamic>> result = await dio.post<Map<String, dynamic>>(path, data: data, options: options);
    return result.data;
  }

  static clear() {
    dio = null;
  }
}


class ResultData {
  final int code;
  final Map<String, dynamic> data;
  final String message;

  ResultData(this.code, this.data, this.message);
}
