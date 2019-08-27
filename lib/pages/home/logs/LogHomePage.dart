import 'package:flutter/material.dart';
import './widgets/FireInspection.dart';

class LogHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogHomePageState();
}

class _LogHomePageState extends State<LogHomePage> {
//  TabController _tabController = TabController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('重庆建工大厦集团'),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: '防火巡查',),
              Tab(text: '防火检查',),
              Tab(text: '设施维保',),
              Tab(text: '消控室',),
            ],
          ),
        ),
        body: SafeArea(
          top: true,
          child: TabBarView(
            children: <Widget>[
              FireInspection(),
              FireInspection(),
              FireInspection(),
              FireInspection(),
            ],
          ),
        ),
      ),
    );
  }
}

