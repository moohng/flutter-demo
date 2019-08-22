import 'package:flutter/cupertino.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('消息'),
      ),
      child: ListWheelScrollView(
        itemExtent: 20.0,
        children: <Widget>[
          Text('哈哈')
        ],
      ),
    );
  }
}