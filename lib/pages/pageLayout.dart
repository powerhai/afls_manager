import 'package:afls_manager/models/position.dart';
import 'package:afls_manager/pages/pageCell.dart';
import 'package:afls_manager/services/eventBus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageLayoutState();
}

class PageLayoutState extends State<PageLayout> {
  StoreA storage = new StoreA();
  bool displayLabel = false;
  var sc = new ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PageLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    sc.jumpTo(10000.0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //sc.jumpTo(10000.0);
  }

  Widget wgAreas() {
    List<Widget> areas = [];
    storage.areas.sort((a, b) {
      return b.sort - a.sort;
    });
    storage.areas.forEach((a) {
      var wg = Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 20.0),
          // padding: EdgeInsets.all(20.0),
          child: FlatButton(
            child: Text(a.name),
            onPressed: () {
              showCellDetailedInfo(a.name);
            },
            padding: EdgeInsets.all(20.0),
            color: Colors.grey[300],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0))),
          ));
      areas.add(wg);
    });

    var arwt = Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: areas);
    return arwt;
  }

  Widget wgRacks() {
    storage.groups.sort((a, b) {
      return b.sort - a.sort;
    });
    List<Widget> racks = [];
    racks.add(SizedBox(
      height: 10.0,
    ));
    storage.groups.forEach((a) {
      racks.add(wgRack(a.right));
      racks.add(SizedBox(
        height: 5.0,
        child: Container(
          margin: EdgeInsets.only(right: 10.0),
          color: Colors.grey,
        ),
      ));
      racks.add(wgRack(a.left));
      racks.add(SizedBox(
        height: 10.0,
      ));
    });
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: racks);
  }

  Widget wgCells(Shelf s, bool labelVisiable) {
    List<Widget> wgs = [];
    s.cells.forEach((c) {
      wgs.add(Expanded(
        child: labelVisiable
            ? Container(
              margin: EdgeInsets.all(1.0),
              child:FlatButton(
                padding: EdgeInsets.all(5.0),
                onPressed: () {

                  Navigator.pop(context, c.name);
                  //showCellDetailedInfo(c.name);
                },
                color: Colors.grey[200],
                child: Text(c.name),
              ) ,
            ) 
            : Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white)),
                child: Text(labelVisiable ? c.name : ""),
              ),
      ));
    });
    return Row(children: wgs);
  }

  Widget wgShelfs(Rack r, bool labelVisible) {
    List<Widget> wgs = [];
    r.shelves.sort((a, b) {
      return b.shelf - a.shelf;
    });
    r.shelves.forEach((f) {
      var s = wgCells(f, labelVisible);
      wgs.add(Expanded(flex: 1, child: s));
    });

    return Expanded(
      flex: 3,
      child: Container(
        height: labelVisible ? 120.0 : 30.0,
        child: Column(children: wgs),
      ),
    );
  }

  Widget wgRack(Rack r) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0))),
      child: FlatButton(
        padding: EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            wgShelfs(r, this.displayLabel),
            SizedBox(
              width: 5.0,
            ),
            Container(
              width: 30.0,
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Text(r.name),
            ),
          ],
        ),
        onPressed: () {
          chooseCell(r);
        },
      ),
    );
  }

  void showLabels() {
    setLabelDisplay(true);

    sc.jumpTo(1000.0);
  }

  void hideLables() {
    setLabelDisplay(false);
    sc.jumpTo(0.0);
  }

  void setLabelDisplay(bool show) {
    this.setState(() {
      this.displayLabel = show;
    });
  }

  void showCellDetailedInfo(String cellName) {
      EventBusMate eventBusMate = EventBusMate.getInstance(); 
      eventBusMate.bus.fire(new SearchPositionEvent(cellName)); 
  }

  Widget wgRackDetailed(Rack r) {
    var label = Container(
      padding: EdgeInsets.all(10.0),
      child: Text(r.name),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: r.left
              ? BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))
              : BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0))),
    );
    var shelf = Expanded(
        child: Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[wgShelfs(r, true)],
      ),
    ));
    var leftRack = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[label, shelf],
    );
    var rightRack = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[shelf, label],
    );
    return r.left ? rightRack : leftRack;
  }

  void chooseCell(Rack r) async {
    var rack = wgRackDetailed(r);
    var dlContent =
        Container(height: 150.0, padding: EdgeInsets.all(10.0), child: rack);
    var pt = await showDialog<String>(
        context: this.context,
        builder: (c) {
          return Dialog(
            child: dlContent,
          );
        });
    if (pt.isEmpty) return;
    showCellDetailedInfo(pt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("仓库布局"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          //IconButton(icon: Icon(Icons.layers), onPressed: showLabels),
          //IconButton(icon: Icon(Icons.layers_clear), onPressed: hideLables)
        ],
      ),
      body: SingleChildScrollView(
        controller: sc,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: wgRacks(),
              flex: 7,
            ),
            Expanded(
              flex: 2,
              child: wgAreas(),
            )
          ],
        ),
      ),
    );
  }
}
