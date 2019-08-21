import 'package:flutter/cupertino.dart';
// import 'package:amap_base/amap_base.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}

class _MapPageState extends State<MapPage> {

  // AMapController _aMapController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('地图'),
      ),
      // child: AMapView(
      //   amapOptions: AMapOptions(
      //     zoomGesturesEnabled: true,
      //   ),
      // ),
      child: Center(child: Text('ddd'),),
    );
  }
}