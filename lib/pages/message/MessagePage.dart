import 'package:flutter/material.dart';
import 'package:flutter_demo/router.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessagePageState();
  }
}

class _MessagePageState extends State<MessagePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      ScrollPosition _position = _controller.position;
      final double scrollOffset = _position.pixels;
      final double maxScrollOffset = _position.maxScrollExtent;
      if (scrollOffset >= maxScrollOffset) {
        print('加载更多');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '消息',
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
//        backgroundColor: Colors.orange,
        onRefresh: () => Future.delayed(Duration(seconds: 2)),
        child: ListView.builder(
          controller: _controller,
//          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 30,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
//                  leading: Image.network(
//                    'https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png',
//                    width: 30,
//                    height: 30,
//                  ),
                  contentPadding: EdgeInsets.only(left: 16.0, right: 16.0),
                  leading: Icon(
                    Icons.message,
                    size: 30,
                    color: Colors.lightBlue,
                  ),
                  title: Text('消息标题'),
                  subtitle: Text(
                    '这是一条很长很长的消息，有很多很多的内容， 有很多很多的内容， 有很多很多的内容',
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
//                    alignment: Alignment.center,
                    child: Text(
                      '2019-05-23',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
//                  enabled: true,
                  onTap: () {
                    Router.push(context, 'https://www.baidu.com', const { 'a': 'qqqqq' });
                  },
                ),
                Divider(
                  height: 1,
                  indent: 60,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
