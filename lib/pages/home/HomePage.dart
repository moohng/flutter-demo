import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amap_base/amap_base.dart';
// import 'package:flutter_demo/services/API.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/widgets/BottomDragWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  AMapLocation _aMapLocation = AMapLocation();
  AMapController _aMapController;

  double get screenH => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();

    // fetchData();

//    fetchLocation();

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
      _aMapController.changeLatLng(LatLng(_location.latitude, _location.longitude));
      _aMapController.setZoomLevel(12);
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

    return BottomDragWidget(
      body: AMapView(
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
      dragContainer: DragContainer(
        drawer: Container(
//          child: OverscrollNotificationWidget(
            child: Container(
              height: 200,
            ),
//          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
            )
          ),
        ),
        defaultShowHeight: screenH * 0.1,
        height: screenH * 0.8,
      ),
    );
  }
}

//showCupertinoDialog(
//  context: context,
//  builder: (context) {
//    return CupertinoAlertDialog(
//      title: Text('提示'),
//      actions: <Widget>[
//        CupertinoButton(child: Text('确定'), onPressed: () => Navigator.of(context).pop(),),
//        CupertinoButton(child: Text('取消'), onPressed: () => Navigator.of(context).pop(),),
//      ],
//      content: Text('这是一段内容，这是一段内容，这是一段内容这是一段内容这是一段内容，这是一段内容这是一段内容。这是一段内容？'),
//    );
//  },
//);