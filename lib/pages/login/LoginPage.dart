import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return  _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.lightBackgroundGray,
      child: GestureDetector(
        child: Center(
          child: Text('登录'),
        ),
        onTap: () {
          Router.pushAndRemoveUntil(context, Router.HOME_PAGE, null);
        },
      )
    );
  }
}
