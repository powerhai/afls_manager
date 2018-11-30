 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
import 'package:flutter/services.dart';

class PageLogin extends StatefulWidget {
  _PageLoginState createState() => _PageLoginState();
}

enum Sex { male, female, none }
enum EyeColor { brown, hazel, green, blue, unknown }
enum Education { elementary, high_school, college, postgrad }

class _PageLoginState extends State<PageLogin> {
  @override
  void initState(){
    super.initState();
    SystemChannels.keyEvent.setMessageHandler((a){
      print("key message here1 ");
    });
    RawKeyboard.instance.addListener((a){
      if(a is RawKeyDownEvent)
      {
        RawKeyEventDataAndroid c  = a.data as RawKeyEventDataAndroid; 
        print("code: ${c.keyCode}  flages: ${c.flags} codePoint: ${c.codePoint} metaState ${c.metaState}");
      }
     
    });
  }
  String mName = "";
  String mPassword = "";
  bool mRemenberPass = true;
  GlobalKey<FormState> mFormKey = new GlobalKey<FormState>();
  final mScaffoldkey = new GlobalKey<ScaffoldState>();
  _PageLoginState() {}

  Widget wgAccount() {
    return new TextFormField(
        onSaved: (s) {
          this.mName = s;
        },
        validator: (a) {
          return a == "" ? "输入错误" : null;
        },
        initialValue: mName,
        autovalidate: false,
        decoration: const InputDecoration(
            hintText: '请输入你的帐号',
            labelText: '帐号',
            contentPadding: const EdgeInsets.all(5.0)));
  }

  Widget wgPassword() {
    return TextFormField(
        initialValue: mPassword,
        obscureText: true,
        onSaved: (s) {
          this.mPassword = s;
        },
        decoration: const InputDecoration(
            border: const UnderlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            hintText: '请输入你的密码',
            labelText: '密码',
            contentPadding: const EdgeInsets.all(5.0)));
  }

  Widget wgRememberPassword() {
    return new CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: new Text("记住密码"),
      onChanged: (bool value) {
        this.setState(() {
          mRemenberPass = value;
        });
      },
      value: mRemenberPass,
    );
  }

  Widget wgSubmitButton() {
    return new RaisedButton(
      onPressed: submitForm,
      child: Text("登录"),
    );
  }

  void submitForm() {
    mFormKey.currentState.save();
    SnackBar s = SnackBar(content: Text(this.mPassword));
    mScaffoldkey.currentState.showSnackBar(s);  
    Navigator.pushNamed(context,   "main");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        key: mScaffoldkey,
        appBar: AppBar(
          title: Text("艾菲乐斯 - 登录"),
        ),
        body: Container(
            child: Form(
          key: mFormKey,
          child: Column(
            children: <Widget>[
              wgAccount(),
              wgPassword(),
              wgRememberPassword(),
              wgSubmitButton(),
            ],
          ),
        )));
  }
}
