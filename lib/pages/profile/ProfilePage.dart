import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/router.dart';
import 'package:flutter_demo/widgets/Toast.dart';

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
          onPressed: () {
            _openDialog();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/profile_bg.png'),
            SafeArea(
              child: CustomScrollView(
//              physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 104.0, left: 16.0, right: 16.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 50.0),
                                padding: EdgeInsets.only(top: 56.0, bottom: 18.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4.0)],
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Text('李四', style: TextStyle(fontSize: 18.0),),
                                    Text('13744566910', style: TextStyle(color: Colors.grey[500]),),
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Center(
                                  child: Container(
                                    width: 78.0,
                                    height: 78.0,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: Image.network(
                                      'https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('设置'),
                            trailing: Icon(Icons.chevron_right),
                            leading: Icon(Icons.settings),
                            onTap: () {
                              Toast.show(context, '你呀你呀，就是一个大傻逼，大快来咬我啊！！！').then((value) {
                                print('toast closed');
                              });
                            },
                          ),
                          Divider(
                            height: 1,
                            indent: 64,
                          ),
                        ],
                      );
                    }, childCount: 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
