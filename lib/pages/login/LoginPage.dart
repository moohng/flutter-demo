import 'package:flutter/material.dart';
import 'package:flutter_demo/router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return  _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          children: <Widget>[
            SizedBox(height: 120,),
            Text('欢迎您，', style: TextStyle(fontSize: 24.0),),
            SizedBox(height: 8.0,),
            Text(
              '请使用您的手机号码登录',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 48,),
            Container(
//              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _phoneController,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: '手机号',
//                      border: InputBorder.none,
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    maxLength: 20,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: '密码',
//                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
//                        dragStartBehavior: DragStartBehavior.down,
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            ButtonBar(
//            mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  textColor: Colors.redAccent,
                  child: Text('重置'),
                  onPressed: () {
                    setState(() {
                      _phoneController.clear();
                      _passwordController.clear();
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: Text('登录'),
                  onPressed: () {
                    Router.pushAndRemoveUntil(context, Router.HOME_PAGE, null);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
