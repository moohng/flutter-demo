import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/main/TabBarPage.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(0, 0, 0, 0),
      systemNavigationBarColor: CupertinoColors.activeBlue,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Startup Name Generator',
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeBlue),
      home: TabBarPage(),
    );
  }
}
