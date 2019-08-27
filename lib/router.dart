import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';
import 'package:flutter_demo/pages/main/TabBarPage.dart';
import 'package:flutter_demo/pages/webview/WebviewPage.dart';
import 'package:flutter_demo/pages/home/UnitListPage.dart';
import 'package:flutter_demo/pages/home/logs/LogHomePage.dart';

class Router {
  static const HOME_PAGE = 'app://';
  static const LOGIN_PAGE = 'app://login';
  static const UNIT_LIST = 'app://unit-list';
  static const LOG_HOME = 'app://log-home';

  Router.push(BuildContext context, String url, Map<String, dynamic> params) {
    Widget _page = _getPage(url, params);
    if (_page == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('页面不存在'),
              ));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return _page;
      }));
    }
  }

  Router.pushAndRemoveUntil(
      BuildContext context, String url, Map<String, dynamic> params) {
    Widget _page = _getPage(url, params);
    if (_page == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('页面不存在'),
              ));
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return _page;
      }), (route) {
        return false;
      });
    }
  }

  Widget _getPage(String url, Map<String, dynamic> params) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return WebviewPage(url, params: params);
    }
    switch (url) {
      case LOGIN_PAGE:
        return LoginPage();
      case HOME_PAGE:
        return TabBarPage();
      case UNIT_LIST:
        return UnitListPage(params);
      case LOG_HOME:
        return LogHomePage();
      default:
        return null;
    }
  }
}
