import 'package:flutter/material.dart';
import 'package:flutter_demo/router.dart';

class UnitListPage extends StatefulWidget {
  final String title;
  final String from;

  UnitListPage(Map<String, dynamic> params, {Key key})
      : title = params['title'],
        from = params['from'],
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UnitListPageState();
  }
}

class _UnitListPageState extends State<UnitListPage> {
  final List<Map> _unitList = [
    {'unitName': '重庆爱情海公司01', 'id': '0'},
    {'unitName': '重庆爱情海公司02', 'id': '1'},
    {'unitName': '重庆爱情海公司03', 'id': '2'},
    {'unitName': '重庆爱情海公司04', 'id': '3'},
    {'unitName': '重庆爱情海公司05', 'id': '4'},
    {'unitName': '重庆爱情海公司06', 'id': '5'},
  ];

  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return _SearchPage();
                  }));
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
//                        showSearch = true;
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            Map item = _unitList[index];

            return Dismissible(
              key: Key(item['id']),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(item['unitName']),
                    onTap: () {
                      Router.push(context, Router.LOG_HOME, null);
                    },
                  ),
                  Divider(
                    height: 1.0,
                  ),
                ],
              ),
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('提示'),
                        content: Text('确定删除${item['unitName']}？'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('确定'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              return true;
                            },
                          ),
                        ],
                      );
                    });
              },
              onDismissed: (DismissDirection direction) {
                _unitList.removeAt(index);
              },
              background: Container(
                color: Color(0xffea474a),
//                child: ListTile(
//                  trailing: Icon(Icons.delete, color: Colors.white,),
//                ),
              ),
              direction: DismissDirection.endToStart,
              dismissThresholds: {DismissDirection.endToStart: 0.2},
            );
          },
          itemCount: _unitList.length,
        ));
  }
}

class _SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> {
  final List<Map> _unitList = [
    {'unitName': '重庆爱情海公司01', 'id': '0'},
    {'unitName': '重庆爱情海公司02', 'id': '1'},
    {'unitName': '重庆爱情海公司03', 'id': '2'},
    {'unitName': '重庆爱情海公司04', 'id': '3'},
    {'unitName': '重庆爱情海公司05', 'id': '4'},
    {'unitName': '重庆爱情海公司06', 'id': '5'},
  ];

  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          showCursor: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: '请输入单位名称',
            border: InputBorder.none,
            suffix: GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {},
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Map item = _unitList[index];

          return Column(
            children: <Widget>[
              ListTile(
                title: Text(item['unitName']),
                onTap: () {
                  Router.push(context, Router.LOG_HOME, null);
                },
              ),
              Divider(
                height: 1.0,
              ),
            ],
          );
        },
        itemCount: _unitList.length,
      ),
    );
  }
}
