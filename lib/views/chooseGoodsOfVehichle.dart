import 'package:afls_manager/controls/group_box.dart';
import 'package:afls_manager/models/Vehichles.dart';
import 'package:afls_manager/models/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChooseGoodsOfVehichle extends StatefulWidget {
  final List<Vehichle> vehichles;
  final String goodsBarcode;

  const ChooseGoodsOfVehichle({Key key, this.vehichles, this.goodsBarcode})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChooseGoodsOfVehichleState();
}

class _ChooseGoodsOfVehichleState extends State<ChooseGoodsOfVehichle> {
  List<BillGoods> goods =[];
  @override
  void initState() {
    super.initState();
    loadData();
  }
  void loadData(){
      for(Vehichle v in this.widget.vehichles){
        for(VehichleShelf s in v.shelves){
          for(VehichleCell c in s.cells){
            for(BillGoods g in c.goods){
              if(g.barcode == this.widget.goodsBarcode){
                goods.add(g);
              }
            }
          }
        }
      }
  }

  Color getCellColor(BillGoods g) {
    if (g == null) return Colors.blue[50];

    if (g.pickFailed) return Colors.red[200];
    return Colors.green[200];
  }

  BillGoods getCurGoods(VehichleCell c) {
    BillGoods g;
    for (var a in c.goods) {
      if (a.barcode == this.widget.goodsBarcode) {
        g = a;
        break;
      }
    }
    return g;
  }

  bool needPick(BillGoods g) {
    if (g == null) return false;

    if (g.needPickCount > g.pickedCount) {
      return true;
    }
    return false;
  }

  void selectCell(BillGoods g) { 
    if (g == null) return null;
    this.setState((){
      g.pickFailed = !g.pickFailed;
    }); 
  }

  Widget wgDialogVehichle(Vehichle v) {
    var cn = Column(
      children: <Widget>[],
    );
    v.shelves.forEach((s) {
      List<Widget> cs = [];
      s.cells.forEach((c) {
        var g = getCurGoods(c);

        cs.add(Expanded(
          child: Container(
              height: 23.0,
              color: Colors.blue[50],
              margin: EdgeInsets.all(0.5),
              alignment: Alignment.center,
              child: needPick(g)
                  ? FlatButton(
                      color: getCellColor(g),
                      padding: EdgeInsets.all(0.0),
                      child: Text(g.needPickCount.toString()),
                      onPressed: () {
                        this.selectCell(g);
                      },
                    )
                  : Text("")),
        ));
      });

      Widget sw = Container(
        child: Row(
          children: cs,
        ),
      );

      cn.children.add(sw);
    });
    Widget t = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.local_grocery_store,
            size: 15.0,
          ),
          Text("  ${v.no + 1}")
        ],
      ),
    );
    return Container(
        child: GroupBox(
      backgroundColor: Colors.blue[200],
      padding: 3.0,
      header: t,
      content: cn,
    ));
  }

  //对话框- 小车
  Widget wgDialogVehichles() {
    List<Widget> vswg = [];
    this.widget.vehichles.forEach((v) {
      vswg.add(wgDialogVehichle(v));
    });
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        GridView.count(
          children: vswg,
          crossAxisCount: 2,
          shrinkWrap: true,
          crossAxisSpacing: 5.0,
          padding: EdgeInsets.all(5.0),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(""),
            ),
            RaisedButton(
              child: Text("取消"),
              onPressed: cancel,
            ),
            SizedBox(
              width: 10.0,
            ),
            RaisedButton(
              child: Text("确定"),
              onPressed: done,
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return wgDialogVehichles();
  }

  void cancel() {
    Navigator.pop(this.context);
  }

  void done() { 
    for(BillGoods b in this.goods){
      if(b.pickFailed!= true){
        b.pickedCount = b.needPickCount;
      }
    }
    Navigator.pop(this.context, this.goods);
  }
}
