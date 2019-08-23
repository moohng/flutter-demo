//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息', style: TextStyle(color: Colors.white),),
        centerTitle: true,
//        brightness: Brightness.dark,
        elevation: 0.0,
      ),
      body: Center(
        child: Text('哈哈')
      ),
    );
  }
}