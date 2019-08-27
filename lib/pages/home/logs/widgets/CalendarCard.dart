import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCard extends StatelessWidget {
  final Function(DateTime, List<dynamic>) _onDaySelected;
  final CalendarController _calendarController;
  final List<String> warnList;
  final List<String> successList;

  CalendarCard(
      {Key key,
      this.warnList,
      this.successList,
      Function(DateTime, List<dynamic>) onDaySelected,
      CalendarController calendarController})
      : _calendarController = calendarController,
        _onDaySelected = onDaySelected ?? ((_, a) {}),
        super(key: key);

  Map<DateTime, List> get _events {
    Map<DateTime, List> data = {};
    warnList.forEach((item) {
      data[DateTime.parse(item)] = ['warning'];
    });
    successList.forEach((item) {
      data[DateTime.parse(item)] = ['success'];
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8.0)],
      ),
      child: TableCalendar(
        calendarController: _calendarController,
        events: _events,
        calendarStyle: CalendarStyle(
          selectedColor: Colors.lightBlue,
          todayColor: Colors.lightBlue[200],
          markersColor: Colors.orange,
        ),
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
        ),
        availableCalendarFormats: const {CalendarFormat.month: ''},
        locale: 'zh_CN',
        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];
            Color _color;

            if (events.isNotEmpty) {
              if (events.contains('success')) {
                _color = Colors.lightGreen;
              } else if (events.contains('warning')) {
                _color = Colors.orange;
              }
              children.add(Positioned(
                bottom: 6.0,
                child: Center(
                    child: Icon(
                  Icons.fiber_manual_record,
                  color: _color,
                  size: 10.0,
                )),
              ));
            }
            return children;
          },
        ),
        onDaySelected: _onDaySelected,
      ),
    );
  }
}
