import 'package:afls_manager/services/config.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PageSetup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageSetupState();
}

class PageSetupState extends State<PageSetup> {
  FlutterBlue blueService = FlutterBlue.instance;
  List<String> blueDevices = new List<String>();

  PageSetupState() {
   
  }
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  int shelfCount = 0;
  int cellCount = 0;
  String printer = "";
  String steelyard = "";
  Config config = Config.getInstance();
  bool scanningBlueDevices = false;



  Widget wdHeaderBluetooch() {
    return Container(
        child: Text(
          "蓝牙",
          style: new TextStyle(fontStyle: FontStyle.italic),
        ),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft);
  }

  Widget wdPrinter() {
    return Container(
        color: Colors.white,
        child: ListTile(
          title: Text("蓝牙打印机"),
          onTap: () {
            selectBlueDevice(choosePrinter);
          },
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(printer),
              new Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ));
  }

  Widget wdSteelyard() {
    return Container(
        color: Colors.white,
        child: ListTile(
          title: Text("蓝牙电子秤"),
          onTap: () {
            selectBlueDevice(this.chooseSteelyard);
          },
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(steelyard),
              new Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ));
  }

  Widget wdHeaderVehicle() {
    return Container(
        child: Text(
          "拣货小车",
          style: new TextStyle(fontStyle: FontStyle.italic),
        ),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft);
  }

  Widget wdShelf() {
    return Container(
        color: Colors.white,
        child: ListTile(
          title: Text("层数"),
          trailing: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: new Icon(
                    Icons.remove_circle_outline,
                    size: 28.0,
                  ),
                  onPressed: this.shelfCount <= 1 ? null : removeShelfCount,
                  disabledColor: Colors.grey[200],
                ),
                Text(
                  this.shelfCount.toString(),
                  style: new TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: new Icon(
                      Icons.add_circle_outline,
                      size: 28.0,
                    ),
                    disabledColor: Colors.red,
                    onPressed: addShelfCount)
              ],
            ),
          ),
        ));
  }

  Widget wdCell() {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          title: Text("格数"),
          trailing: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    disabledColor: Colors.grey[200],
                    icon: new Icon(
                      Icons.remove_circle_outline,
                      size: 28.0,
                    ),
                    onPressed: this.cellCount <= 1 ? null : removeCellCount),
                Text(
                  this.cellCount.toString(),
                  style: new TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: new Icon(
                    Icons.add_circle_outline,
                    size: 28.0,
                  ),
                  onPressed: addCellCount,
                )
              ],
            ),
          ),
        ));
  }

  removeShelfCount() {
    if (shelfCount <= 1) return;
    this.setState(() {
      this.shelfCount--;
    });
    config.saveShelfCount(this.shelfCount);
  }

  addShelfCount() {
    this.setState(() {
      this.shelfCount++;
    });
    config.saveShelfCount(this.shelfCount);
  }

  removeCellCount() {
    if (cellCount <= 1) return;
    this.setState(() {
      this.cellCount--;
    });
    config.saveCellCount(this.cellCount);
  }

  addCellCount() {
    this.setState(() {
      this.cellCount++;
    });
    config.saveCellCount(this.cellCount);
  }

  void choosePrinter() async {
    List<Widget> ops = [];
    for (var i = 0; i < blueDevices.length; i++) {
      var dev = blueDevices[i];
      var op = new SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, dev);
        },
        child: Row(
          children: <Widget>[
            Icon(dev == this.printer
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            SizedBox(
              width: 10.0,
            ),
            Text(dev)
          ],
        ),
      );
      ops.add(op);
    }
    var pt = await showDialog<String>(
      builder: (c) {
        return SimpleDialog(
          title: Text("选择蓝牙打印机"),
          children: ops,
          contentPadding: EdgeInsets.all(10.0),
        );
      },
      context: this.context,
    );
    if (pt == null) return;
    scaffoldkey.currentState.hideCurrentSnackBar();
    scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text(pt),
    ));
    this.setState(() {
      this.printer = pt;
    });
    config.savePrinter(pt);
  }

  void chooseSteelyard() async {
    List<Widget> ops = [];
    for (var i = 0; i < blueDevices.length; i++) {
      var dev = blueDevices[i];
      var op = new SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, dev);
        },
        child: Row(
          children: <Widget>[
            Icon(dev == this.steelyard
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            SizedBox(
              width: 10.0,
            ),
            Text(dev)
          ],
        ),
      );
      ops.add(op);
    }
    var pt = await showDialog<String>(
      builder: (c) {
        return SimpleDialog(
          title: Text("选择蓝牙电子秤"),
          children: ops,
          contentPadding: EdgeInsets.all(10.0),
        );
      },
      context: this.context,
    );
    if (pt == null) return;
    scaffoldkey.currentState.hideCurrentSnackBar();
    scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text(pt),
    ));
    this.setState(() {
      this.steelyard = pt;
    });
    config.saveSteelyard(pt);
  }

  void selectBlueDevice(void done()) async {
    this.setState(() {
      scanningBlueDevices = true;
    });
    blueDevices.clear();
    var des = await blueService.getBondedDevices();
    des.forEach((d) {
      blueDevices.add(d.name);
    });

    this.setState(() {
      scanningBlueDevices = false;
    });
    done();
  }
  @override
  void initState() {
    super.initState();
     _loadinitdata = loadInitData();
  }

  var _loadinitdata;

  Future<bool> loadInitData() async {
    await config.load();
    this.shelfCount = config.shelfCount ?? 4;
    this.cellCount = config.cellCount ?? 4;
    this.steelyard = config.steelyard ?? "";
    this.printer = config.printer ?? ""; 
    //await Future.delayed(Duration(seconds: 5));
    //throw FormatException("error of tcp");
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: new AppBar(
          title: new Text("设置"),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
            child: FutureBuilder(
          future: _loadinitdata,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.none:
                {
                  return Text("准备初始化");
                }
              case ConnectionState.waiting:
                {
                  return Center(child: CupertinoActivityIndicator( ) ,); 
                }
              case ConnectionState.done:
                {
                  if(snapshot.hasError){
                    var ex = snapshot.error as FormatException;
                    return Center(child:Text("初始化错误： ${ex.message}"));
                  }
                   
                  return body();
                }
            }
          },
        )));
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        new Column(
          children: <Widget>[
            wdHeaderBluetooch(),
            wdPrinter(),
            Divider(
              height: 1.0,
            ),
            wdSteelyard(),
            wdHeaderVehicle(),
            wdShelf(),
            Divider(height: 1.0),
            wdCell()
          ],
        ),
        new Offstage(
          offstage: !this.scanningBlueDevices,
          child: Container(
            color: Color.fromRGBO(122, 122, 122, 0.5),
            constraints: const BoxConstraints(
                minHeight: double.infinity, minWidth: double.infinity),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }
}
