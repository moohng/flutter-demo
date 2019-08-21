import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/main/TabBarPage.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.light,
    );
    // 状态栏
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  // 强制竖屏
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // await SystemChrome.restoreSystemUIOverlays();
  await initializeDateFormatting();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isLogin = true;
    return CupertinoApp(
      title: 'Startup Name Generator',
      theme: CupertinoThemeData(primaryColor: Colors.lightBlue),
      home: isLogin ? TabBarPage() : LoginPage(),
    );
  }
}
