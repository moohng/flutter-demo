import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/pages/home/HomePage.dart';
import 'package:flutter_demo/pages/message/MessagePage.dart';
import 'package:flutter_demo/pages/profile/ProfilePage.dart';


class TabBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabBarPageState();
  }
}

class _TabBarPageState extends State<TabBarPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [HomePage(), MessagePage(), ProfilePage()];
  List<BottomNavigationBarItem> _itemList = [
    BottomNavigationBarItem(
      title: Text('首页'),
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      title: Text('消息'),
      icon: Icon(Icons.message),
    ),
    BottomNavigationBarItem(
      title: Text('我的'),
      icon: Icon(Icons.settings),
    ),
  ];


  @override
  void initState() {
    super.initState();
  }

  Widget _getPage(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: pages[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _itemList,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0.0,
        unselectedFontSize: 14.0,
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Stack(
        children: [
          _getPage(0),
          _getPage(1),
          _getPage(2),
        ],
      ),
    );
  }
}
