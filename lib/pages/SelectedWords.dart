import 'package:flutter/material.dart';

class SelectedWords extends StatelessWidget {
  final List<Widget> divided;
  SelectedWords(this.divided);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Saved Suggestions'),),
      body: ListView(children: divided,),
    );
  }
}