import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import './CardItem.dart';
import './CalendarCard.dart';

class FireInspection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FireInspectionState();
}

class _FireInspectionState extends State<FireInspection> with AutomaticKeepAliveClientMixin {

  bool get wantKeepAlive => true;

  // 日历
  CalendarController _calendarController;

  // 数据源
  final List<Map<String, dynamic>> options = [
    { 'label': '任务名称', 'key': 'taskName' },
    { 'label': '巡查人', 'key': 'name' },
    { 'label': '开始时间', 'key': 'startTime' },
    { 'label': '结束时间', 'key': 'endTime' },
  ];
  final Map<String, dynamic> data = {
    'taskName': '龙湖国际花园二期防火巡查',
    'name': '兰庆',
    'startTime': '2018-03-22 23:44:12',
    'endTime': '2018-03-22 23:44:12',
  };

  final List<String> _completedList = [
    '2019-08-01',
    '2019-07-28',
  ];
  final List<String> _uncompletedList = [
    '2019-08-05',
    '2019-08-22',
    '2019-08-10',
  ];

  @override
  void initState() {
    _calendarController = CalendarController();

    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: CalendarCard(
            warnList: _uncompletedList,
            successList: _completedList,
            calendarController: _calendarController,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.fiber_manual_record, color: Colors.orange, size: 12.0,),
                Text(' 已补录  ', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                Icon(Icons.fiber_manual_record, color: Colors.lightGreen, size: 12.0,),
                Text(' 已完成  ', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                Icon(Icons.fiber_manual_record, color: Colors.lightBlue, size: 12.0,),
                Text(' 当前日', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: List(4).map<Widget>((val) {
              return CardItem(
                options: options,
                  data: data,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
