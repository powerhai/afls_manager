 
import 'package:afls_manager/services/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 

class PageMoveTo extends StatefulWidget {
  String goodsName;
  String goodsBarcode;
  String goodsPosition;

  PageMoveTo(this.goodsName, this.goodsBarcode, this.goodsPosition) {}
  @override
  State<StatefulWidget> createState() => PageMoveToState();
}

class PageMoveToState extends State<PageMoveTo> { 
  Config _config;
  String targetPosition; 
  bool forceMove = false;
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    _config =    Config.getInstance();
    await _config.load();
    this.setState(() {
      this.forceMove =_config.forceMove ?? false;
    });
  }

  void setForceMove(bool v) {
    this.setState(() {
      this.forceMove = v;
    });
    _config.saveForceMove(v); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("移位"),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(this.widget.goodsName,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Text(
                  "条码： ${this.widget.goodsBarcode}  位置: ${this.widget.goodsPosition}"),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  onChanged: (c) {
                    this.setState(() {
                      targetPosition = c;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "货位条码",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 2.0,
                          borderRadius: new BorderRadius.circular(4.0)),
                      border: OutlineInputBorder(
                          gapPadding: 2.0,
                          borderRadius: new BorderRadius.circular(4.0)),
                      contentPadding: EdgeInsets.all(5.0))),
              Row(
                children: <Widget>[
                  Text("强制移动"),
                  SizedBox(
                    width: 10.0,
                  ),
                  Checkbox(
                    value: forceMove,
                    onChanged: setForceMove,
                  ),
                ],
              ),
              RaisedButton(child: Text("确定"), onPressed: move)
            ],
          ),
        ));
  }

  void move() {}
}
