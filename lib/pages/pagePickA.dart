import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PagePickA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePickAState();
}

class PagePickAState extends State<PagePickA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("配货 -  二次配货"),
          automaticallyImplyLeading: true,
        ),
        body: new Column(children: <Widget>[ 
          TextField( decoration:  const InputDecoration(
            border: const UnderlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            hintText: '请输入你的密码',
            labelText: '配货',
            contentPadding: const EdgeInsets.all(5.0)))
        ],));
  }
}
