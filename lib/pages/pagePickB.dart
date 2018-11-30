 
import 'package:afls_manager/controls/group_box.dart';
import 'package:afls_manager/models/Vehichles.dart';
import 'package:afls_manager/models/position.dart';
import 'package:afls_manager/services/config.dart';
import 'package:afls_manager/views/cellDetailsOfVehichle.dart';
import 'package:afls_manager/views/chooseGoodsOfVehichle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PagePickB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagePickBState();
}

class PagePickBState extends State<PagePickB> {
  Color colorFinish = Colors.greenAccent[100];
  Color colorNone = Colors.grey[200];
  Color colorInit = Colors.white;
  Color colorFailed = Colors.red[100];
  Color colorPicking = Colors.yellow[50];

  StoreA store = new StoreA();
  List<Vehichle> vehichles = [];
  List racks = [];
  List<UnitRelation> units = [];
  UnitRelation unknowUnit;
  Config _config;
  int shelfCount;
  int cellCount;

  String bill;
  bool picking = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void bindData() {
    var items = [
      {
        "GoodsName": "万向地插",
        "Goods": "Y-DXPJ-1",
        "Position": "B1-1-2",
        "Count": 3,
        "Put": [
          {"CellNo": 1, "Count": 1},
          {"CellNo": 28, "Count": 2},
        ]
      },
      {
        "GoodsName": "万向地插",
        "Goods": "Y-DXPJ-133A",
        "Position": "C2-2-1",
        "Count": 3,
        "Put": [
          {"CellNo": 5, "Count": 1},
          {"CellNo": 11, "Count": 2},
        ]
      },
      {
        "GoodsName": "万向地插",
        "Goods": "Y-DXPJ-135A",
        "Position": "asdf",
        "Count": 3,
        "Put": [
          {"CellNo": 6, "Count": 1},
          {"CellNo": 28, "Count": 2},
        ]
      },
      {
        "GoodsName": "万向地插333",
        "Goods": "Y-DXPJ-5327A",
        "Position": "Z-02",
        "Count": 3,
        "Put": [
          {"CellNo": 8, "Count": 1},
          {"CellNo": 16, "Count": 2},
        ]
      },
      {
        "GoodsName": "万向地插333",
        "Goods": "Y-DXPJ-5221A",
        "Position": "D2-1-2",
        "Count": 32,
        "Put": [
          {"CellNo": 38, "Count": 32},
        ]
      },
      {
        "GoodsName": "万向地插333",
        "Goods": "Y-DXPJ-591A",
        "Position": "D2-1-3",
        "Count": 1,
        "Put": [
          {"CellNo": 2, "Count": 1},
        ]
      },
      {
        "GoodsName": "万向地插333",
        "Goods": "Y-DXPJ-5329A",
        "Position": "D2-1-3",
        "Count": 25,
        "Put": [
          {"CellNo": 2, "Count": 1},
          {"CellNo": 18, "Count": 22},
          {"CellNo": 48, "Count": 2},
        ]
      },
    ];
    loadUnits(store);
    for (dynamic item in items) {
      var u = getUnit(item["Position"]);

      if (!isRackOrAreaExist(u.parent.name)) {
        this.racks.add(u.parent);
      }
      this.racks.sort((a, b) {
        return a.sort - b.sort;
      });
      var bg = BillGoods(
          name: item["GoodsName"],
          position: item["Position"],
          barcode: item["Goods"],
          needPickCount: item["Count"],
          pickedCount: 0);
      u.unit.billgoods.add(bg);
      //Bind Vehichles
      var puts = item["Put"];
      for (var put in puts) {
        VehichleCell vc = getVehichleCell(put["CellNo"]);
        var bgc = BillGoods(
            name: item["GoodsName"],
            position: item["Position"],
            barcode: item["Goods"],
            needPickCount: put["Count"],
            pickedCount: 0);
        vc.goods.add(bgc);
      }
    }
  }

  VehichleCell getVehichleCell(int no) {
    VehichleCell cl;
    for (Vehichle v in this.vehichles) {
      for (VehichleShelf s in v.shelves) {
        for (VehichleCell c in s.cells) {
          if (c.no == no) {
            cl = c;
            break;
          }
        }
      }
    }
    return cl;
  }

  bool isRackOrAreaExist(String name) {
    bool b = false;
    for (var item in this.racks) {
      if (item.name == name) {
        b = true;
        break;
      }
    }
    return b;
  }

  void loadUnits(StoreA store) {
    units = [];
    for (RackGroup g in store.groups) {
      List<Rack> rs = [g.left, g.right];
      for (Rack r in rs) {
        for (Shelf s in r.shelves) {
          for (Cell c in s.cells) {
            units.add(new UnitRelation(c, r));
          }
        }
      }
    }
    for (Area a in store.areas) {
      units.add(new UnitRelation(a, a));
      if (a.name == "") {
        unknowUnit = UnitRelation(a, a);
      }
    }
  }

  UnitRelation getUnit(var positionCode) {
    UnitRelation u = unknowUnit;
    for (UnitRelation uc in this.units) {
      if (uc.unit.name == positionCode) {
        u = uc;
        break;
      }
    }
    return u;
  }

  void loadData() async {
    _config = Config.getInstance();
    await _config.load();

    this.setState(() {
      this.shelfCount = _config.shelfCount;
      this.cellCount = _config.cellCount;
      loadVehichles();
    });
  }

  void loadVehichles() {
    vehichles.add(new Vehichle(vehichles.length, shelfCount, cellCount));
    vehichles.add(new Vehichle(vehichles.length, shelfCount, cellCount));
    vehichles.add(new Vehichle(vehichles.length, shelfCount, cellCount));
  }

  Widget wgRackShelf(Shelf s) {
    List<Widget> cs = [];
    s.cells.forEach((c) {
      cs.add(Expanded(flex: 1, child: wgRackCellContent(c)));
    });
    return Container(
        child: IntrinsicHeight(
            child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cs,
    )));
  }

  Widget wgRackCellContent(Unit r) {
    var c = Column(
      children: <Widget>[],
    );

    r.billgoods.forEach((g) {
      print(g);
      c.children.add(Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        height: 30.0,
        color: getRackCellGoodsColor(g),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                g.barcode,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
              ),
              Text(
                g.needPickCount.toString(),
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                    fontSize: 11.0),
              )
            ],
          ),
          onPressed: () {
            chooseGoods(g);
          },
        ),
      ));
    });
    return Container(
      margin: EdgeInsets.all(0.5),
      color: getRackCellColor(r),
      constraints: BoxConstraints(minHeight: 20.0),
      child: c,
    );
  }

  Color getRackCellColor(Unit u) {
    return colorNone;

    //return u.billgoods.length > 0 ? colorInit : colorNone;
  }

  Color getRackCellGoodsColor(BillGoods g) {
    if (g.pickedCount >= g.needPickCount) {
      return colorFinish;
    }
    if (g.pickedCount != 0) return colorPicking;
    return colorInit;
  }

  Color getCellColorOfVehichle(VehichleCell c) {
    if (c.goods.length == 0) {
      return colorNone;
    }
    if (c.pickFinished == true) return colorFinish;
    if (c.pickFailed == true) return colorFailed;
    if (c.picking == true) return colorPicking;
    return colorInit;
  }

  Widget wgVehichleCells(VehichleShelf s) {
    List<Widget> cells = [];
    s.cells.forEach((c) {
      cells.add(
        Expanded(
            child: Container(
          margin: EdgeInsets.all(0.5),
          height: 28.0,
          color: getCellColorOfVehichle(c),
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            child: Text(c.needPick ? c.needPickCount.toString() : ""),
            onPressed: c.needPick
                ? () {
                    showVehichleDetails(c);
                  }
                : null,
          ),
        )),
      );
    });
    return Row(
      children: cells,
    );
  }

  void showVehichleDetails(VehichleCell c) {
    var dlc = VehichleCellDetails(cell: c);

    showDialog(
        context: this.context,
        builder: (c) {
          return Dialog(
            child: dlc,
          );
        });
  }

  Widget wgVehichle(Vehichle vehichle) {
    Widget v = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.local_grocery_store),
          Text("  ${vehichle.no + 1}")
        ],
      ),
    );

    List<Widget> ss = [];

    vehichle.shelves.forEach((s) {
      var sw = wgVehichleCells(s);
      ss.add(sw);
    });

    return Container(
        child: GroupBox(
          padding: 5.0,
          header: v,
          content: Column(children: ss),
          backgroundColor: Colors.grey[300],
        ),
        padding: EdgeInsets.all(10.0));
  }

  Widget wgVehichlesPanel() {
    List<Widget> vs = [];
    this.vehichles.forEach((v) {
      vs.add(wgVehichle(v));
    });
    return SingleChildScrollView(
      child: Column(
        children: vs,
      ),
    );
  }

  Widget wgPickGroupPanel() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            color: Colors.grey[300],
            child: new TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey[500],
                tabs: [
                  new Tab(
                    icon: new Icon(Icons.directions_walk),
                  ),
                  new Tab(
                    icon: new Icon(Icons.view_module),
                  ),
                ])),
        Expanded(
            child: new TabBarView(children: [
          wgPickingPanel(),
          wgVehichlesPanel(),
        ]))
      ],
    ));
  }

  Widget wgPickingPanel() {
    return SingleChildScrollView(
      child: wgMenu(),
    );
  }

  Widget wgMenu() {
    List<Widget> ls = [];

    this.racks.forEach((o) {
      if (o is Rack) {
        ls.add(wgRack(o as Rack));
      }
      if (o is Area) {
        ls.add(wgArea(o));
      }
    });
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: ls,
        ));
  }

  Widget wgRack(Rack r) {
    Widget header = Text(r.name);
    List<Widget> ss = [];

    r.shelves.forEach((s) {
      var sw = wgRackShelf(s);
      ss.add(sw);
    });

    return Container(
        padding: EdgeInsets.fromLTRB(
            r.left ? 0.0 : 28.0, 0.0, r.left ? 28.0 : 0.0, 10.0),
        child: GroupBox(
          header: header,
          padding: 5.0,
          backgroundColor: Colors.grey[300],
          content: Column(children: ss),
          headerPosition: r.left ? HeaderPosition.Left : HeaderPosition.Right,
        ));
  }

  Widget wgArea(Area a) {
    List<Widget> sfs = [];
    Widget header = Text(a.name.isEmpty ? "  ?  " : a.name);
    Widget content = wgRackCellContent(a);
    return Container(
        padding: EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 10.0),
        child: GroupBox(
          backgroundColor: Colors.grey[300],
          header: header,
          content: content,
        ));
  }

  Widget wgInputBillPanel() {
    return Container(
        color: Colors.grey[400],
        padding: EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                  onChanged: (v) {
                    this.setState(() {
                      this.bill = v;
                    });
                  },
                  decoration: const InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '输入汇总单号',
                      contentPadding: const EdgeInsets.all(5.0))),
            ),
            IconButton(
              icon: Icon(
                Icons.play_circle_filled,
                size: 35.0,
              ),
              onPressed: startPick,
            )
          ],
        ));
  }

  void startPick() {
    this.setState(() {
      bindData();
      this.picking = true;
    });
  }

  void chooseGoods(BillGoods g) async {
    if (g.pickedCount == g.needPickCount) return;
    var pt = await showDialog<List<BillGoods>>(
        context: this.context,
        builder: (c) {
          return Dialog(
            child: ChooseGoodsOfVehichle(
              vehichles: this.vehichles,
              goodsBarcode: g.barcode,
            ),
          );
        });
    if (pt != null) {
      var picked = 0;
      for (BillGoods gc in pt) {
        picked += gc.pickedCount;
        print(
            "${g.barcode} items: ${pt.length} ${g.needPickCount} ${g.pickedCount} ${g.pickFailed} ");
      }

      this.setState(() {
        g.pickedCount = picked;
        print(
            "${g.barcode} items: ${pt.length} ${g.needPickCount} ${g.pickedCount} ${g.pickFailed} ");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return DefaultTabController(
      child: Scaffold(
          appBar: new AppBar(
            title: new Text("配货 - 分单汇总"),
            automaticallyImplyLeading: true,
          ),
          body: picking ? wgPickGroupPanel() : wgInputBillPanel()),
      length: 2,
    );
  }
}

class UnitRelation {
  Unit unit;
  var parent;
  UnitRelation(this.unit, this.parent);
}
