import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PagePick extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePickState();
}

class PagePickState extends State<PagePick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("配货"),
          automaticallyImplyLeading: true,
        ),
        body: GridView.count(
          padding: EdgeInsets.all(20.0),
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40.0),
              child: RaisedButton(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.view_list,
                      size: 40.0,
                      color: Colors.blue,
                    ),
                    Text("二次配货")
                  ],
                ),
                onPressed: null,
              ),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              child: RaisedButton(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.view_module,
                      size: 40.0,
                      color: Colors.blue,
                    ),
                    Text("分单汇总")
                  ],
                ),
                onPressed: pickB,
              ),
            ),
          ],
        ));
  }

  void pickB() {
    Navigator.pushNamed(context, "pickB");
  }
  void pickA() {
    Navigator.pushNamed(context, "pickA");
  }
}
