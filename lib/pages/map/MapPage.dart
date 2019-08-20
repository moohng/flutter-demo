import 'package:flutter/cupertino.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapPageState();
  }
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('地图'),
      ),
      child: Center(child: Text('地图'),),
    );
  }
}