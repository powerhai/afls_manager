import 'package:afls_manager/pages/pageLogin.dart';
import 'package:afls_manager/pages/pageMain.dart';
import 'package:afls_manager/pages/pagePick.dart';
import 'package:afls_manager/pages/pagePickA.dart';
import 'package:afls_manager/pages/pagePickB.dart';  
import 'package:flutter/material.dart';

void main() => runApp(new MainScreen());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "艾菲乐斯 - 仓储管理",
        debugShowCheckedModeBanner: false,
        home: new PageLogin(),
        /*theme: ThemeData(
            primaryColor: Colors.cyan[400],
            primaryColorLight: Colors.tealAccent[200]),*/
        routes: <String, WidgetBuilder>{
          "main": (BuildContext context) => PageMain(),
          "pick": (BuildContext c) => PagePick(),
          "pickA": (BuildContext c) => PagePickA(),
          "pickB": (BuildContext c) => PagePickB(),
          
        });
  }
}
