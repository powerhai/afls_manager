import 'package:afls_manager/models/goodsInfo.dart';
import 'package:afls_manager/pages/pageMoveTo.dart';
import 'package:afls_manager/services/config.dart';
import 'package:afls_manager/services/eventBus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageSearchState();
}

class PageSearchState extends State<PageSearch> {
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();
  EventBusMate eventBusMate = EventBusMate.getInstance();
  int panelIndex = 1;
  bool isBlueEnabled = false;
  bool isBlueConfiged = true;
  String printer;
  String position = "Z-01";
  GoodsInfoB goods = new GoodsInfoB(
      name: "多功能金杖 15cm",
      count: 3,
      monthCount: 6,
      yearCount: 12,
      barcode: "Y-C-13",
      position: "新仓库 > S-12",
      positions: [
        GoodsPositionInfo(position: "新仓库 > S-12", count: 1),
        GoodsPositionInfo(position: "新仓库 > S133", count: 3)
      ]);
  List<GoodsInfo> goodses = [
    GoodsInfo(
        name: "艾菲乐斯7P发动机",
        barcode: "Y-C-12",
        count: 3,
        position: "新仓库 > Z-01",
        selected: true),
    GoodsInfo(
        name: "艾菲7P发动机", barcode: "Y-C-12", count: 3, position: "新仓库 > Z-01"),
    GoodsInfo(
        name: "艾菲乐斯7P发动机",
        barcode: "Y-C-13",
        count: 3,
        position: "新仓库 > Z-01",
        selected: true),
    GoodsInfo(
        name: "艾菲乐斯7P发动机",
        barcode: "Y-C-12",
        count: 3,
        position: "新仓库 > Z-03",
        selected: true),
    GoodsInfo(
        name: "艾菲7P发动机", barcode: "Y-C-16", count: 2, position: "新仓库 > Z-01"),
    GoodsInfo(
        name: "艾菲乐斯7P发动机", barcode: "Y-C-12", count: 3, position: "新仓库 > Z-01"),
    GoodsInfo(
        name: "乐斯7P发动机", barcode: "Y-C-19", count: 3, position: "新仓库 > Z-02"),
    GoodsInfo(
        name: "艾菲乐斯7P发动机",
        barcode: "Y-C-12",
        count: 3,
        position: "新仓库 > Z-01",
        selected: true)
  ];
  List<Widget> goodsRows = [];
  Config config = Config.getInstance();
  var _loadinitdata;

  @override
  void initState() {
    super.initState();
    _loadinitdata = loadInitData();
    eventBusMate.bus.on<SearchPositionEvent>().listen((data) {
      this.setState(() {
        position = data.position;
        panelIndex = 1;
      });
    });
  }

  Future<bool> loadInitData() async {
    await config.load();
    this.printer = config.printer ?? "";
    await Future.delayed(Duration(seconds: 5));
    return true;
  }

  Widget wgHeader() {
    return Container(
      color: Colors.grey[200],
      height: 51.0,
      constraints: const BoxConstraints(minWidth: double.infinity),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FlatButton(
              padding: EdgeInsets.all(0.0),
              color: panelIndex == 0 ? Colors.blue[300] : Colors.grey[350],
              onPressed: () {
                this.setState(() {
                  panelIndex = 0;
                });
              },
              child: Text("货品"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0))),
            ),
          ),
          Expanded(
              flex: 1,
              child: IntrinsicHeight(
                  child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      color:
                          panelIndex == 0 ? Colors.grey[350] : Colors.blue[300],
                      onPressed: () {
                        this.setState(() {
                          panelIndex = 1;
                        });
                      },
                      child: Text("货位"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0)))))),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
              flex: 4,
              child: TextField(
                  decoration: InputDecoration(
                      hintText: panelIndex == 0 ? "输入货品条码" : "输入货位条码",
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 2.0,
                          borderRadius: new BorderRadius.circular(8.0)),
                      border: OutlineInputBorder(
                          gapPadding: 2.0,
                          borderRadius: new BorderRadius.circular(8.0)),
                      contentPadding: EdgeInsets.all(5.0)))),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              this.setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              this.setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget wgPostionPanel() {
    return Container(
        child: new FutureBuilder(
             
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.none:
                  {
                    return Text("准备初始化");
                  }
                case ConnectionState.waiting:
                  {
                    return Text("正在初始化...");
                  }
                case ConnectionState.done:
                  {
                    return Text("ok");
                  }
              }
            }));
  }

  Widget wgPostionPanel2() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.grey[300],
            child: Row(children: [
              Text(
                "货位: ${position}",
                style: TextStyle(
                    color: Theme.of(this.context).hintColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(""),
              ),
              IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: selectAll,
              ),
              IconButton(
                  icon: Icon(Icons.radio_button_unchecked),
                  onPressed: unselected),
              IconButton(
                  icon: Icon(Icons.print),
                  onPressed: () {
                    printLabels();
                  }),
            ])),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemBuilder: wgGoodsRow,
            itemCount: goodses.length,
          ),
        )
      ],
    ));
  }

  void selectAll() {
    this.setState(() {
      goodses.forEach((g) {
        g.selected = true;
      });
    });
  }

  void unselected() {
    this.setState(() {
      goodses.forEach((g) {
        g.selected = false;
      });
    });
  }

  Widget wgGoodsPanel() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              goods.name,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(children: <Widget>[Text("条码: ${goods.barcode}")])),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("总数: ${goods.count}"),
                Text("月销: ${goods.monthCount}"),
                Text("年销: ${goods.yearCount}")
              ],
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: wgPositionRow,
              itemCount: goods.positions.length,
            ),
          )
        ],
      ),
    );
  }

  Widget wgPositionRow(BuildContext context, int index) {
    var p = goods.positions[index];
    return Container(
        decoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 1.0, color: Colors.grey[200])),
        child: ListTile(
          title: Text("位置:  ${p.position}"),
          subtitle: Text("数量:  ${p.count}"),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.print),
                  onPressed: () {
                    printLabel(goods.name, "", goods.barcode);
                  }),
              IconButton(
                  icon: Icon(Icons.place),
                  onPressed: () {
                    moveTo(goods.name, goods.barcode, goods.position);
                  })
            ],
          ),
        ));
  }

  Widget wgGoodsRow(BuildContext context, int index) {
    var g = this.goodses[index];
    return Container(
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1.0, color: Colors.grey[200])),
      child: ListTile(
        trailing: IconButton(
            icon: Icon(Icons.place),
            onPressed: () {
              moveTo(g.name, g.barcode, g.position);
            }),
        leading: Icon(
          g.selected == true
              ? Icons.check_circle
              : Icons.radio_button_unchecked,
          size: 20.0,
          color:
              g.selected == true ? Theme.of(context).primaryColor : Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
        title: Text(g.name),
        subtitle: Text("条码： ${g.barcode}  数量: ${g.count}"),
        onTap: () {
          this.setState(() {
            g.selected = !g.selected;
          });
        },
      ),
    );
  }

  void moveTo(String goodsName, String goodsBarcode, String position) async {
 

    Navigator.push(context, new MaterialPageRoute(builder: (c) {
      return new PageMoveTo(goodsName, goodsBarcode, position);
    }));
  }

  void printLabels() {
  
    if (!checkBluePrinter()) {
      return;
    }
    goodses.forEach((g) {
      if (g.selected == true) {
        printLabel(g.name, "", g.barcode);
      }
    });
  }

  bool checkBluePrinter() {
    if (!isBlueEnabled) {
      scaffoldkey.currentState.hideCurrentSnackBar();
      scaffoldkey.currentState
          .showSnackBar(SnackBar(content: Text("蓝牙打印机未连接！")));
      return false;
    }
    return true;
  }

  void printLabel(String goodsName, String goodsSubtitle, String goodsBarcode) {
    if (!checkBluePrinter()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.scaffoldkey,
        appBar: new AppBar(
          title: new Text("搜索"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.bluetooth),
              onPressed: () {},
            ),
          ],
        ),
        body: FutureBuilder(
          future: _loadinitdata,
          builder: (BuildContext content, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.none:
                {
                  return Text("准备初始化");
                }
              case ConnectionState.waiting:
                {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              case ConnectionState.done:
                {
                  if (snapshot.hasError) {
                    var ex = snapshot.error as FormatException;
                    return Center(child: Text("初始化错误： ${ex.message}"));
                  } 
                  return body();
                }
            }
          },
        ));
  }

  Widget body() {
    return new Column(
      children: <Widget>[
        wgHeader(),
        Expanded(
          child: IndexedStack(
            index: panelIndex,
            children: <Widget>[wgGoodsPanel(), wgPostionPanel()],
          ),
        )
      ],
    );
  }
}
