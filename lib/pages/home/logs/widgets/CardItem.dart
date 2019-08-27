import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  /// [
  ///   { 'label': '任务名称', 'key': 'taskName' },
  /// ]
  final List<Map<String, dynamic>> options;
  final Map<String, dynamic> data;

  CardItem({ Key key, @required this.options, @required this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6.0)],
      ),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options.map((Map<String, dynamic> item) {
          return Text(
            '${item['label']}：${data[item['key']]??''}',
          );
        }).toList(),
      ),
    );
  }
}