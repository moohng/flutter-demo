import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/main/TabBarPage.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

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
  // 极光推送
  String debugLabel = 'Unknown';
  final JPush _jpush = new JPush();

  @override
  void initState() {
    super.initState();

//    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    _jpush.getRegistrationID().then((rid) {
      setState(() {
        print('flutter getRegistrationID: $rid');
      });
    });

    _jpush.setup(
      appKey: '71c7c1c041f7e0f6650db7e2',
      channel: "theChannel",
      production: false,
      debug: true,
    );

    try {
      _jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print('flutter onOpenNotification: $message');
          setState(() {
            debugLabel = 'flutter onOpenNotification: $message';
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print('flutter onOpenNotification: $message');
          setState(() {
            debugLabel = 'flutter onOpenNotification: $message';
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print('flutter onReceiveMessage: $message');
          setState(() {
            debugLabel = 'flutter onReceiveMessage: $message';
          });
        }
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      debugLabel = platformVersion;
    });
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
