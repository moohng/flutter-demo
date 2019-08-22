import 'package:flutter/cupertino.dart';
import 'package:amap_base_map/amap_base_map.dart';

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
      child: AMapView(
        amapOptions: AMapOptions(
          compassEnabled: true,
          zoomControlsEnabled: false,
          logoPosition: LOGO_POSITION_BOTTOM_CENTER,
          // camera: CameraPosition(
          //   target: LatLng(40.851827, 111.801637),
          //   zoom: 20,
          // ),
        ),
      ),
      // child: Center(child: Text('ddd'),),
    );
  }
}
