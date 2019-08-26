import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:amap_base/amap_base.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/services/API.dart';
//import 'package:shared_preferences/shared_preferences.dart';
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

  List<Map> _listItem = [
    {
      'iconCode': 0xe611,
      'label': '单位管理',
      'color': Color(0xff5b9dfb),
      'onTap': () {}
    },
    {
      'iconCode': 0xe600,
      'label': '告警管理',
      'color': Color(0xfff1a350),
      'onTap': () {}
    },
    {
      'iconCode': 0xe69b,
      'label': '日志管理',
      'color': Color(0xff60ceb1),
      'onTap': () {}
    },
    {
      'iconCode': 0xe6cc,
      'label': '督办管理',
      'color': Color(0xff60ceb1),
      'onTap': () {}
    },
    {
      'iconCode': 0xe640,
      'label': '系统监测',
      'color': Color(0xff5b9dfb),
      'onTap': () {}
    },
  ];

  List<Map> _messageList = [
    {
      'content': '警报，警报！收到一条消息，请及时处理，请及时处理',
      'time': '2018-11-23 16:22:51',
    },
  ];

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
      Location _location =
          await _aMapLocation.getLocation(LocationClientOptions(
        isOnceLocation: true,
      ));
      _aMapController
          .changeLatLng(LatLng(_location.latitude, _location.longitude));
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
          child: Column(
            children: <Widget>[
              Container(
                height: 107,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _listItem.map((Map item) {
                    return _buildListItem(
                      color: item['color'],
                      iconCode: item['iconCode'],
                      label: item['label'],
                      onTap: item['onTap'],
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text('最新消息'),
                    ),
                    ..._messageList.map((Map item) => _buildMessageItem(
                      message: item['content'],
                      time: item['time'],
                    )).toList(),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              )),
        ),
        defaultShowHeight: 120,
        height: 530,
      ),
    );
  }

  Widget _buildListItem(
      {Color color, Function onTap, int iconCode, String label}) {
    return MaterialButton(
      padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  IconData(iconCode, fontFamily: 'Iconfont'),
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _buildMessageItem({ String message, String time }) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.0)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            alignment: Alignment.bottomRight,
            child: Text(
              time,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
