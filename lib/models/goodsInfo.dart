class GoodsInfo {
  GoodsInfo(
      {this.name,
      this.barcode,
      this.position,
      this.count,
      this.selected = false});
  String name;
  String barcode;
  int count;
  String position;
  bool selected;
}

class GoodsInfoB extends GoodsInfo {
  int monthCount;
  int yearCount;
  List<GoodsPositionInfo> positions  = [];
    GoodsInfoB({this.monthCount = 0, this.positions, this.yearCount = 0, String name, String barcode, String position, int count, bool selected = false})
      : super(
          name: name, barcode:barcode, position:position, count:count, selected:selected
        ) ;
}

class GoodsPositionInfo{
    String position;
    int count;
    GoodsPositionInfo({this.position, this.count});
}