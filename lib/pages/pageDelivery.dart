import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageDelivery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageDeliveryState();
}

class PageDeliveryState extends State<PageDelivery> {
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  FocusNode focusNode = new FocusNode();
  List<String> bagers = [];
  List<String> pickers = [];
  String barcode = "";
  String bager = "";
  String picker = "";
  String weight = "";
  String price = "";
  bool delivery = false;
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Widget wgBager() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListTile(
          title: Text("打包员"),
          onTap: chooseBager,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(bager),
              new Icon(Icons.keyboard_arrow_right)
            ],
          )),
    );
  }

  Widget wgPicker() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: ListTile(
          title: Text("拣货员"),
          onTap: choosePicker,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(picker),
              new Icon(Icons.keyboard_arrow_right)
            ],
          )),
    );
  }

  Widget wgWeight() {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          title: Text("重量"),
          trailing: Text(this.weight),
        ));
  }

  Widget wgPrice() {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          title: Text("邮费"),
          trailing: Text(this.price),
        ));
  }

  Widget wgDelivery() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SwitchListTile(
        onChanged: (bool value) {
          this.setState(() {
            this.delivery = value;
          });
        },
        value: delivery,
        title: Text("扫描后直接发货"),
      ),
    );
  }

  Widget wgButton() {
    return Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: RaisedButton(
          child: new Text("确认发货"),
          onPressed: () {},
        ));
  }

  Widget wgBarcode() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300]),
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: TextField(
                focusNode: focusNode,
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "输入快递单号",
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.grey),
                        gapPadding: 2.0,
                        borderRadius: new BorderRadius.circular(4.0)),
                    border: OutlineInputBorder(
                        gapPadding: 2.0,
                        borderRadius: new BorderRadius.circular(4.0)),
                    contentPadding: EdgeInsets.all(5.0)),
              )),
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.search),
            onPressed: () {
              focusNode.unfocus();
            },
          )
        ],
      ),
    );
  }

  void loadBagers() {
    this.bagers = ["黄药师", "李淑婷", "姐就拽"];
  }

  void loadPickers() {
    this.pickers = ["苍鹰", "黄药师", "小妹妹", "小姐姐", "黄小二"];
  }

  void choosePicker() async {
    loadPickers();
    List<Widget> ops = [];
    pickers.forEach((s) {
      var op = new SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, s);
        },
        child: Row(
          children: <Widget>[
            Icon(s == this.picker
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            SizedBox(
              width: 10.0,
            ),
            Text(s)
          ],
        ),
      );
      ops.add(op);
    });
    var pt = await showDialog<String>(
      builder: (c) {
        return SimpleDialog(
          title: Text("选择拣货员"),
          children: ops,
          contentPadding: EdgeInsets.all(10.0),
        );
      },
      context: this.context,
    );
    if (pt == null) return;

    this.setState(() {
      this.picker = pt;
    });
  }

  void chooseBager() async {
    loadBagers();
    List<Widget> ops = [];
    bagers.forEach((s) {
      var op = new SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, s);
        },
        child: Row(
          children: <Widget>[
            Icon(s == this.bager
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            SizedBox(
              width: 10.0,
            ),
            Text(s)
          ],
        ),
      );
      ops.add(op);
    });
    var pt = await showDialog<String>(
      builder: (c) {
        return SimpleDialog(
          title: Text("选择打包员"),
          children: ops,
          contentPadding: EdgeInsets.all(10.0),
        );
      },
      context: this.context,
    );
    if (pt == null) return;

    this.setState(() {
      this.bager = pt;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("re build");
    return Scaffold(
        key: scaffoldkey,
        appBar: new AppBar(
          title: new Text("发货"),
          automaticallyImplyLeading: false,
        ),
        body: new ListView(
          children: <Widget>[
            wgBarcode(),
            SizedBox(
              height: 30.0,
            ),
            wgBager(),
            Divider(
              height: 1.0,
            ),
            wgPicker(),
            SizedBox(
              height: 30.0,
            ),
            wgWeight(),
            Divider(
              height: 1.0,
            ),
            wgPrice(),
            Divider(
              height: 1.0,
            ),
            wgDelivery(),
            SizedBox(
              height: 20.0,
            ),
            wgButton()
          ],
        ));
  }
}
