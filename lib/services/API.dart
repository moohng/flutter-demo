import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_demo/utils/HttpUtil.dart';

class API {
  static Future login() {
    String username = 'server';
    String password = 'server';
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return HttpUtil.post('/cuaa/oauth/token',
      data: {
        'scope': 'all',
        'sysType': 3,
        'grant_type': 'password',
        'type': 'login',
        'username': '19923766075',
        'password': '123456',
      },
      options: Options(
        headers: {
          'Authorization': basicAuth,
        },
        contentType: ContentType.parse('application/x-www-form-urlencoded'),
      )
    );
  }
}
