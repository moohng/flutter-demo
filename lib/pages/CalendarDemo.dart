import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalendarDemoState();
  }
}

class _CalendarDemoState extends State {
  Map<DateTime, List> _events;
  List _selectedEvents;
  CalendarController _calendarController;
//  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['warning'],
      _selectedDay.subtract(Duration(days: 27)): ['success'],
      _selectedDay.subtract(Duration(days: 20)): ['warning'],
      _selectedDay.subtract(Duration(days: 16)): ['warning'],
      _selectedDay.subtract(Duration(days: 10)): ['success'],
      _selectedDay.subtract(Duration(days: 4)): ['success'],
      _selectedDay.subtract(Duration(days: 2)): ['success'],
      _selectedDay: ['success'],
      _selectedDay.add(Duration(days: 1)): ['warning'],
      _selectedDay.add(Duration(days: 7)): ['success'],
      _selectedDay.add(Duration(days: 11)): ['success'],
      _selectedDay.add(Duration(days: 17)): ['warning'],
      _selectedDay.add(Duration(days: 22)): ['success'],
      _selectedDay.add(Duration(days: 26)): ['success'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];

    _calendarController = CalendarController();

//    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400),);
//    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
//    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar demo'),
      ),
      body: TableCalendar(
        calendarController: _calendarController,
        events: _events,
        calendarStyle: CalendarStyle(
          selectedColor: Colors.lightBlue,
          todayColor: Colors.lightBlue[200],
          markersColor: Colors.orange,
          markersPositionBottom: 8,
        ),
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
        ),
        availableCalendarFormats: const { CalendarFormat.month: '' },
        locale: 'zh_CN',
        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];
            Color _color;

            if (events.isNotEmpty) {
              if (events.contains('success')) {
                _color = Colors.lightGreen;
              } else {
                _color = Colors.orange;
              }
              children.add(Positioned(
                bottom: 8,
                child: Center(
                    child: Icon(Icons.brightness_1, color: _color, size: 8,)
                ),
              ));
            }

            return children;
          },
        ),
      ),
    );
  }
}
