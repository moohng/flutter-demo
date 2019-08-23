import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';
import 'package:flutter_demo/router.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        child: Center(
          child: CupertinoButton(
            child: Text('去登录'),
            onPressed: () {
              Router.push(context, Router.LOGIN_PAGE, null);
            },
          ),
        ),
      ),
    );
  }
}
