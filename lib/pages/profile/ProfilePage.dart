import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('我的'),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('去登录'),
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return LoginPage();
            }));
          },
        ),
      ),
    );
  }
}
