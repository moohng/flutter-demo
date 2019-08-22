import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amap_base/amap_base.dart';
// import 'package:flutter_demo/services/API.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  AMapLocation _aMapLocation = AMapLocation();
  AMapController _aMapController;

  @override
  void initState() {
    super.initState();

    // fetchData();

    fetchLocation();

  }

  void fetchData() async {
    // Map<String, dynamic> data = await API.login();

    // SharedPreferences shared = await SharedPreferences.getInstance();
    // shared.setString('ACCESS_TOKEN', jsonEncode(data));

    // String s = shared.getString('ACCESS_TOKEN');
    // var d = jsonDecode(s);

    // print('data: ${data['user_name']['tenantList'][0]['domain']}');
  }

  fetchLocation() async {
    bool p = await Permissions().requestPermission();
    if (p) {
      _aMapLocation.init();
      Location _location = await _aMapLocation.getLocation(LocationClientOptions(
        isOnceLocation: true,
      ));
//      _aMapController.changeLatLng(LatLng(_location.latitude, _location.longitude));
      print(_location);
//      _aMapLocation.startLocate(LocationClientOptions()).listen((data) {
//        print('location $data');
//      });

    } else {
      print('no permissions');
    }
  }

  @override
  void dispose() {
    super.dispose();

    _aMapController.dispose();
//    _aMapLocation.stopLocate();
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      child: AMapView(
        amapOptions: AMapOptions(
          zoomControlsEnabled: false,
          camera: CameraPosition(
            zoom: 12,
          ),
        ),
        onAMapViewCreated: (controller) {
          setState(() {
            _aMapController = controller;
          });
        },
      ),
      // child: Center(child: Text('ddd'),),
    );
//    return CupertinoPageScaffold(
//      navigationBar: CupertinoNavigationBar(
//        middle: Text('首页', style: TextStyle(color: CupertinoColors.white),),
//        backgroundColor: Colors.lightBlue,
//      ),
//      child: PageView(
//        children: <Widget>[
//          GestureDetector(
//            child: Text('首页'),
//            onTap: () {
//              showCupertinoDialog(
//                context: context,
//                builder: (context) {
//                  return CupertinoAlertDialog(
//                    title: Text('提示'),
//                    actions: <Widget>[
//                      CupertinoButton(child: Text('确定'), onPressed: () => Navigator.of(context).pop(),),
//                      CupertinoButton(child: Text('取消'), onPressed: () => Navigator.of(context).pop(),),
//                    ],
//                    content: Text('这是一段内容，这是一段内容，这是一段内容这是一段内容这是一段内容，这是一段内容这是一段内容。这是一段内容？'),
//                  );
//                },
//              );
//            },
//          ),
//        ],
//      ),
//    );
  }
}
