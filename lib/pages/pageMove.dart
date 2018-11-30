import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageMove extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageMoveState();
}

class PageMoveState extends State<PageMove>
     {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: new AppBar(
          title: new Text("移动"),
          automaticallyImplyLeading: false,
        ),
        body: new Column(
          children: <Widget>[
            
            RaisedButton(
              child: new Text("pick"),
              onPressed: () {
                Navigator.pushNamed(context, "pick");
              },
            )
          ],
        ));
  }
 
 
}
