//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/pages/home/HomePage.dart';
import 'package:flutter_demo/pages/map/MapPage.dart';
import 'package:flutter_demo/pages/profile/ProfilePage.dart';
import 'package:flutter_demo/pages/login/LoginPage.dart';


class TabBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabBarPageState();
  }
}

class _TabBarPageState extends State<TabBarPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [HomePage(), MapPage(), ProfilePage()];
  List<BottomNavigationBarItem> _itemList = [
    BottomNavigationBarItem(
      title: Text('首页'),
      icon: Icon(CupertinoIcons.home),
    ),
    BottomNavigationBarItem(
      title: Text('地图'),
      icon: Icon(CupertinoIcons.eye),
    ),
    BottomNavigationBarItem(
      title: Text('我的'),
      icon: Icon(CupertinoIcons.settings),
    ),
  ];


  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 5), () {
    //   Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) {
    //     return LoginPage();
    //   }));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _itemList,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return pages[index];
          },
        );
      },
    );
  }
}
