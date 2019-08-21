import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/utils/HttpUtil.dart';
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
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    Response response = await HttpUtil.get('''s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=flutter%20网络请求&oq=flutter%2520%25E7%25BD%2591%25E7%25BB%259C%25E8%25AF%25B7%25E6%25B1%2582&rsv_pq=f3ca83c10016a9d6&rsv_t=f576pKqz%2BbCUtwtNoQbGhJ%2Fpq%2BeLPj2CIaJ5FrO1N%2FAC%2FVEiM5YT8ZhITdI&rqlang=cn&rsv_enter=0&rsv_dl=tb''');
    print(response);
  }

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
