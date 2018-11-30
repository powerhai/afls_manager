import 'package:afls_manager/controls/haiTile.dart';
import 'package:afls_manager/models/Vehichles.dart';
import 'package:afls_manager/models/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VehichleCellDetails extends StatelessWidget {
  const VehichleCellDetails({Key key, this.cell}) : super(key: key);

  final VehichleCell cell;
  Widget wgGoods(BillGoods g) {
    return HaiTile(
      contentPadding: EdgeInsets.all(3.0),
      title: Text(
        g.name,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      leading: Container(
          padding: EdgeInsets.all(8.0),
          decoration:
              ShapeDecoration(shape: CircleBorder(), color: getGoodsColor(g)),
          child: Text(
            g.needPickCount.toString(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold , color: Colors.white),
          )),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("条码：", style:TextStyle(color: Colors.grey)),
          Text("${g.barcode}" ),
          Text("货位：", style:TextStyle(color: Colors.grey)),
          Text("${g.position}"  )
        ],
      ),
    );
  }

  Color getGoodsColor(BillGoods g){
    if(g.pickedCount == g.needPickCount)
      return Colors.green[300];
    if(g.pickFailed)
      return Colors.red[300];
    return Colors.grey[400];
  }
  List<Widget> wgGoodses() {
    List<Widget> items = [];
    for (BillGoods b in cell.goods) {
      items.add(wgGoods(b));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: wgGoodses(),
    );
  }
}
