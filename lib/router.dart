import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';
import 'package:flutter_demo/pages/main/TabBarPage.dart';
import 'package:flutter_demo/pages/webview/WebviewPage.dart';


class Router {
  static const HOME_PAGE = 'app://';
  static const LOGIN_PAGE = 'app://login';

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return _getPage(url, params);
      }
    ));
  }

  Router.pushAndRemoveUntil(BuildContext context, String url, dynamic params) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return _getPage(url, params);
        }
    ), (route) {
      return false;
    });
  }

  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return WebviewPage(url, params: params);
    }
    switch (url) {
      case LOGIN_PAGE:
        return LoginPage();
      case HOME_PAGE:
        return TabBarPage();
      default:
        return null;
    }
  }
}