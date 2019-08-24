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
  TextEditingController _textController = TextEditingController(text: '');

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('refresh completed');
    });
  }

  void _openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editingController = TextEditingController();
        return AlertDialog(
          title: Text('打开'),
          content: Container(
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                labelText: '请输入页面地址'
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                String urlStr = editingController.text;
                print('=============== $urlStr');
                if (urlStr.isNotEmpty) {
                  Navigator.of(context).pop();
                  Router.push(context, urlStr, null);
                }
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      floatingActionButton: Container(
//        color: Colors.lightBlue,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.lightBlue,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5.0,
            )
          ],
//          borderRadius: BorderRadius.circular(40.0),
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      appBar: AppBar(
        title: Text('个人中心'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _openDialog();
            },
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('设置'),
                      trailing: Icon(Icons.chevron_right),
                      leading: Icon(Icons.settings),
                      onTap: () {},
                    ),
                    Divider(
                      height: 1,
                      indent: 64,
                    ),
                  ],
                );
              }, childCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}
