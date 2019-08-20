import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('首页', style: TextStyle(color: CupertinoColors.white),),
        backgroundColor: Colors.lightBlue,
      ),
      child: Container(
        child: GestureDetector(
          child: Text('首页'),
          onTap: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('提示'),
                  actions: <Widget>[
                    CupertinoButton(child: Text('确定'), onPressed: () => Navigator.of(context).pop(),),
                    CupertinoButton(child: Text('取消'), onPressed: () => Navigator.of(context).pop(),),
                  ],
                  content: Text('这是一段内容，这是一段内容，这是一段内容这是一段内容这是一段内容，这是一段内容这是一段内容。这是一段内容？'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
