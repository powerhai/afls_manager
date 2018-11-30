import 'package:afls_manager/pages/pageDelivery.dart';
import 'package:afls_manager/pages/pageLayout.dart';
import 'package:afls_manager/pages/pagePick.dart';
import 'package:afls_manager/pages/pageSearch.dart';
import 'package:afls_manager/pages/pageSetup.dart';
import 'package:afls_manager/services/eventBus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageMain extends StatefulWidget {
  var sta = PageMainState();
  @override
  State<StatefulWidget> createState() => sta;
}

class PageMainState extends State<PageMain> {
  int tabIndex = 0;
  EventBusMate eventBusMate = EventBusMate.getInstance();

  @override
  void initState() {
    super.initState();
    eventBusMate.bus.on<SearchPositionEvent>().listen((data) {
      this.setState(() {
        tabIndex = 1;
      });
    });
  }

  List<StatefulWidget> pages = [
    PageLayout(),
    PageSearch(),
    PagePick(),
    PageDelivery(),
    PageSetup()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              title: new Text("布局"), icon: new Icon(Icons.business)),
          new BottomNavigationBarItem(
              title: new Text("搜索"), icon: new Icon(Icons.search)),
          new BottomNavigationBarItem(
              title: new Text("配货"), icon: new Icon(Icons.move_to_inbox)),
          new BottomNavigationBarItem(
              title: new Text("发货"), icon: new Icon(Icons.local_shipping)),
          new BottomNavigationBarItem(
              title: new Text("设置"), icon: new Icon(Icons.settings)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
        onTap: (index) {
          this.setState(() {
            this.tabIndex = index;
          });
        },
      ),
      body: IndexedStack(children: pages, index: this.tabIndex),
    );
  }
}
