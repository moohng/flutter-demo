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

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('refresh completed');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
//              backgroundColor: Colors.white,
              expandedHeight: 256.0,
              pinned: true, // 固定顶部
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('个人中心'),
                centerTitle: true,
                background: Image.network(
                  'http://img.anfone.net/Outside/anfone/201666/2016661523021277.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.wrap_text),
                  onPressed: () {},
                )
              ],
              actionsIconTheme: IconThemeData(color: Colors.white),
               leading: Icon(Icons.chevron_left),
              iconTheme: IconThemeData(color: Colors.orange),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Text('item: $index');
              }, childCount: 100),
            ),
//            Container(
//              height: 1000,
//              color: Colors.greenAccent,
//              child: Center(
//                child: CupertinoButton(
//                  child: Text('去登录'),
//                  onPressed: () {
//                    Router.push(context, Router.LOGIN_PAGE, null);
//                  },
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
