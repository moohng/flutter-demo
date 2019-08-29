import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/router.dart';
import 'package:flutter_demo/widgets/Toast.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
//  TextEditingController _textController = TextEditingController(text: '');

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      print('refresh completed');
    });
  }

  void _openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController editingController = TextEditingController();
          return AlertDialog(
            title: Text('打开'),
            content: Container(
              child: TextField(
                controller: editingController,
                decoration: InputDecoration(labelText: '请输入页面地址'),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  String urlStr = editingController.text;
                  if (urlStr.isNotEmpty) {
                    Navigator.of(context).pop();
                    Router.push(context, urlStr, null);
                  }
                },
              )
            ],
          );
        });
  }

  Future<dynamic> _navTo(Widget page) async {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('退出登录'),
                leading: Icon(Icons.person),
                onTap: () {
                  Router.pushAndRemoveUntil(context, Router.LOGIN_PAGE, null);
                },
              ),
              ListTile(
                title: Text('退出应用'),
                leading: Icon(Icons.power_settings_new),
                onTap: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration _decoration = BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4.0)],
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: Colors.white,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_new),
        onPressed: () {
          _openDialog();
        },
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/profile_bg.png'),
            CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          padding: EdgeInsets.only(top: 52.0, bottom: 18.0),
                          alignment: Alignment.center,
                          decoration: _decoration,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    '李四',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text(
                                    '13744566910',
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: -90,
                                child: Center(
                                  child: ProfileAvatar(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: _decoration,
                          child: Column(
                            children: ListTile.divideTiles(
                              context: context,
                              tiles: <Widget>[
                                ListItem(
                                  label: '个人资料',
                                  iconData: Icons.person_outline,
                                  color: Colors.lightBlueAccent,
                                  onTap: () {},
                                ),
                                ListItem(
                                  label: '账号管理',
                                  iconData: Icons.mail_outline,
                                  color: Colors.orangeAccent,
                                  onTap: () {},
                                ),
                                ListItem(
                                  label: '密码修改',
                                  iconData: Icons.lock_outline,
                                  color: Colors.lightBlueAccent,
                                  onTap: () {},
                                ),
                                ListItem(
                                  label: '退出',
                                  iconData: Icons.power_settings_new,
                                  color: Colors.redAccent,
                                  onTap: () {
                                    _showBottomSheet();
                                  },
                                ),
                              ],
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 头像
class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 39,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(
        'https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png',
      ),
    );

//    return Container(
//      width: 78.0,
//      height: 78.0,
//      decoration: BoxDecoration(
//        color: Colors.white,
//        shape: BoxShape.circle,
//        image: DecorationImage(
//          image: NetworkImage(
//            'https://cdn.jsdelivr.net/gh/flutterchina/website@1.0/images/flutter-mark-square-100.png',
//          ),
//        ),
//      ),
//    );
  }
}

// ListItem
class ListItem extends StatelessWidget {
  final Function onTap;
  final String label;
  final IconData iconData;
  final Color color;

  ListItem(
      {Key key,
      @required this.label,
      @required this.iconData,
      @required this.onTap,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: Icon(
        iconData,
        color: color ?? Colors.lightBlue,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey[300],
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
