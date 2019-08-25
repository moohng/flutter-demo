import 'package:flutter/material.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/main/TabBarPage.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,

//     statusBarIconBrightness: Brightness.dark,  暗
  );
  // 状态栏
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // 强制竖屏
   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // await SystemChrome.restoreSystemUIOverlays();
//  await initializeDateFormatting();

  // 错误收集
  CatcherOptions debugOptions = CatcherOptions(
      DialogReportMode(), [ConsoleHandler()],
      localizationOptions: [LocalizationOptions.buildDefaultChineseOptions()]);
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(['moohng@126.com'])
  ]);
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
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
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print('flutter onOpenNotification: $message');
        setState(() {
          debugLabel = 'flutter onOpenNotification: $message';
        });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print('flutter onReceiveMessage: $message');
        setState(() {
          debugLabel = 'flutter onReceiveMessage: $message';
        });
      });
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
    return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      localizationsDelegates: [                             //此处
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      home: isLogin ? TabBarPage() : LoginPage(),
    );
  }
}
