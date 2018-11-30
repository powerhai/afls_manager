import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageCell extends StatefulWidget {
  String cellName;
  PageCell(this.cellName);
  @override
  State<StatefulWidget> createState() => PageCellState();
}

class PageCellState extends State<PageCell> {
  String get cellName => this.widget.cellName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("货位详情"),
          automaticallyImplyLeading: true,
        ),
        body: new Column(
          children: <Widget>[
            RaisedButton(
              child: new Text(cellName),
              onPressed: () {
                Navigator.pushNamed(context, "pick");
              },
            )
          ],
        ));
  }
}
