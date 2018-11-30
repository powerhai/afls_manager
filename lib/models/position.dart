import 'package:afls_manager/models/goodsInfo.dart';

enum PickState {
  Finished,
  InPicking,
}

class BillGoods extends GoodsInfo {
  int pickedCount;
  int needPickCount;
  bool pickFailed = false;

  BillGoods(
      {String name,
      String barcode,
      String position,
      bool selected,
      this.pickedCount = 0,
      this.needPickCount})
      : super(
            name: name,
            barcode: barcode,
            position: position,
            selected: selected);
}

class Unit {
  List<BillGoods> billgoods = [];
  String name;
  Unit(this.name);
}

class Cell extends Unit {
  Cell(String name) : super(name);
}

class Area extends Unit {
  int sort;
  Area(String name, this.sort) : super(name);
}

class Shelf {
  int shelf;
  List<Cell> cells;
  Shelf(this.shelf, this.cells);
}

class Rack {
  String name;
  List<Shelf> shelves;
  bool left;
  int sort;
  Rack(this.name, this.left, this.sort,this.shelves);
}

class RackGroup {
  int sort;
  Rack left;
  Rack right;
  RackGroup(this.sort, this.left, this.right);
}

class StoreA {
  String name = "新仓库";
  List<RackGroup> groups = [
    RackGroup(
        1,
        Rack("A1", true,1, [
          Shelf(1, [Cell("A1-1-1"), Cell("A1-1-2"), Cell("A1-1-3")]),
          Shelf(2, [Cell("A1-2-1"), Cell("A1-2-2"), Cell("A1-2-3")]),
          Shelf(3, [Cell("A1-3-1"), Cell("A1-3-2"), Cell("A1-3-3")]),
          Shelf(4, [Cell("A1-4-1"), Cell("A1-4-2"), Cell("A1-4-3")]),
        ]),
        Rack("A2", false,2, [
          Shelf(1, [Cell("A2-1-1"), Cell("A2-1-2"), Cell("A2-1-3")]),
          Shelf(2, [Cell("A2-2-1"), Cell("A2-2-2"), Cell("A2-2-3")]),
          Shelf(3, [Cell("A2-3-1"), Cell("A2-3-2"), Cell("A2-3-3")]),
          Shelf(4, [Cell("A2-4-1"), Cell("A2-4-2"), Cell("A2-4-3")]),
        ])),
    RackGroup(
        2,
        Rack("B1", true, 3,[
          Shelf(1, [Cell("B1-1-1"), Cell("B1-1-2"), Cell("B1-1-3")]),
          Shelf(2, [Cell("B1-2-1"), Cell("B1-2-2"), Cell("B1-2-3")]),
          Shelf(3, [Cell("B1-3-1"), Cell("B1-3-2"), Cell("B1-3-3")]),
          Shelf(4, [Cell("B1-4-1"), Cell("B1-4-2"), Cell("B1-4-3")]),
        ]),
        Rack("B2", false,4, [
          Shelf(1, [Cell("B2-1-1"), Cell("B2-1-2"), Cell("B2-1-3")]),
          Shelf(2, [Cell("B2-2-1"), Cell("B2-2-2"), Cell("B2-2-3")]),
          Shelf(3, [Cell("B2-3-1"), Cell("B2-3-2"), Cell("B2-3-3")]),
          Shelf(4, [Cell("B2-4-1"), Cell("B2-4-2"), Cell("B2-4-3")]),
        ])),
    RackGroup(
        3,
        Rack("C1", true,5,[
          Shelf(1, [Cell("C1-1-1"), Cell("C1-1-2"), Cell("C1-1-3")]),
          Shelf(2, [Cell("C1-2-1"), Cell("C1-2-2"), Cell("C1-2-3")]),
          Shelf(3, [Cell("C1-3-1"), Cell("C1-3-2"), Cell("C1-3-3")]),
          Shelf(4, [Cell("C1-4-1"), Cell("C1-4-2"), Cell("C1-4-3")]),
        ]),
        Rack("C2", false,6, [
          Shelf(1, [Cell("C2-1-1"), Cell("C2-1-2"), Cell("C2-1-3")]),
          Shelf(2, [Cell("C2-2-1"), Cell("C2-2-2"), Cell("C2-2-3")]),
          Shelf(3, [Cell("C2-3-1"), Cell("C2-3-2"), Cell("C2-3-3")]),
          Shelf(4, [Cell("C2-4-1"), Cell("C2-4-2"), Cell("C2-4-3")]),
        ])),
    RackGroup(
        4,
        Rack("D1", true,7, [
          Shelf(1, [Cell("D1-1-1"), Cell("D1-1-2"), Cell("D1-1-3")]),
          Shelf(2, [Cell("D1-2-1"), Cell("D1-2-2"), Cell("D1-2-3")]),
          Shelf(3, [Cell("D1-3-1"), Cell("D1-3-2"), Cell("D1-3-3")]),
          Shelf(4, [Cell("D1-4-1"), Cell("D1-4-2"), Cell("D1-4-3")]),
        ]),
        Rack("D2", false, 8,[
          Shelf(1, [Cell("D2-1-1"), Cell("D2-1-2"), Cell("D2-1-3")]),
          Shelf(2, [Cell("D2-2-1"), Cell("D2-2-2"), Cell("D2-2-3")]),
          Shelf(3, [Cell("D2-3-1"), Cell("D2-3-2"), Cell("D2-3-3")]),
          Shelf(4, [Cell("D2-4-1"), Cell("D2-4-2"), Cell("D2-4-3")]),
        ])),
    RackGroup(
        5,
        Rack("E1", true,9, [
          Shelf(1, [Cell("E1-1-1"), Cell("E1-1-2"), Cell("E1-1-3")]),
          Shelf(2, [Cell("E1-2-1"), Cell("E1-2-2"), Cell("E1-2-3")]),
          Shelf(3, [Cell("E1-3-1"), Cell("E1-3-2"), Cell("E1-3-3")]),
          Shelf(4, [Cell("E1-4-1"), Cell("E1-4-2"), Cell("E1-4-3")]),
        ]),
        Rack("E2", false, 10,[
          Shelf(1, [Cell("E2-1-1"), Cell("E2-1-2"), Cell("E2-1-3")]),
          Shelf(2, [Cell("E2-2-1"), Cell("E2-2-2"), Cell("E2-2-3")]),
          Shelf(3, [Cell("E2-3-1"), Cell("E2-3-2"), Cell("E2-3-3")]),
          Shelf(4, [Cell("E2-4-1"), Cell("E2-4-2"), Cell("E2-4-3")]),
        ])),
    RackGroup(
        6,
        Rack("F1", true,11, [
          Shelf(1, [Cell("F1-1-1"), Cell("F1-1-2"), Cell("F1-1-3")]),
          Shelf(2, [Cell("F1-2-1"), Cell("F1-2-2"), Cell("F1-2-3")]),
          Shelf(3, [Cell("F1-3-1"), Cell("F1-3-2"), Cell("F1-3-3")]),
          Shelf(4, [Cell("F1-4-1"), Cell("F1-4-2"), Cell("F1-4-3")]),
        ]),
        Rack("F2", false, 12,[
          Shelf(1, [Cell("F2-1-1"), Cell("F2-1-2"), Cell("F2-1-3")]),
          Shelf(2, [Cell("F2-2-1"), Cell("F2-2-2"), Cell("F2-2-3")]),
          Shelf(3, [Cell("F2-3-1"), Cell("F2-3-2"), Cell("F2-3-3")]),
          Shelf(4, [Cell("F2-4-1"), Cell("F2-4-2"), Cell("F2-4-3")]),
        ])),
    RackGroup(
        7,
        Rack("G1", true,13, [
          Shelf(1, [Cell("G1-1-1"), Cell("G1-1-2"), Cell("G1-1-3")]),
          Shelf(2, [Cell("G1-2-1"), Cell("G1-2-2"), Cell("G1-2-3")]),
          Shelf(3, [Cell("G1-3-1"), Cell("G1-3-2"), Cell("G1-3-3")]),
          Shelf(4, [Cell("G1-4-1"), Cell("G1-4-2"), Cell("G1-4-3")]),
        ]),
        Rack("G2", false,14, [
          Shelf(1, [Cell("G2-1-1"), Cell("G2-1-2"), Cell("G2-1-3")]),
          Shelf(2, [Cell("G2-2-1"), Cell("G2-2-2"), Cell("G2-2-3")]),
          Shelf(3, [Cell("G2-3-1"), Cell("G2-3-2"), Cell("G2-3-3")]),
          Shelf(4, [Cell("G2-4-1"), Cell("G2-4-2"), Cell("G2-4-3")]),
        ])),
    RackGroup(
        8,
        Rack("H1", true,15, [
          Shelf(1, [Cell("H1-1-1"), Cell("H1-1-2"), Cell("H1-1-3")]),
          Shelf(2, [Cell("H1-2-1"), Cell("H1-2-2"), Cell("H1-2-3")]),
          Shelf(3, [Cell("H1-3-1"), Cell("H1-3-2"), Cell("H1-3-3")]),
          Shelf(4, [Cell("H1-4-1"), Cell("H1-4-2"), Cell("H1-4-3")]),
        ]),
        Rack("H2", false,16, [
          Shelf(1, [Cell("H2-1-1"), Cell("H2-1-2"), Cell("H2-1-3")]),
          Shelf(2, [Cell("H2-2-1"), Cell("H2-2-2"), Cell("H2-2-3")]),
          Shelf(3, [Cell("H2-3-1"), Cell("H2-3-2"), Cell("H2-3-3")]),
          Shelf(4, [Cell("H2-4-1"), Cell("H2-4-2"), Cell("H2-4-3")]),
        ])),
    RackGroup(
        9,
        Rack("I1", true,17, [
          Shelf(1, [Cell("I1-1-1"), Cell("I1-1-2"), Cell("I1-1-3")]),
          Shelf(2, [Cell("I1-2-1"), Cell("I1-2-2"), Cell("I1-2-3")]),
          Shelf(3, [Cell("I1-3-1"), Cell("I1-3-2"), Cell("I1-3-3")]),
          Shelf(4, [Cell("I1-4-1"), Cell("I1-4-2"), Cell("I1-4-3")]),
        ]),
        Rack("I2", false, 18,[
          Shelf(1, [Cell("I2-1-1"), Cell("I2-1-2"), Cell("I2-1-3")]),
          Shelf(2, [Cell("I2-2-1"), Cell("I2-2-2"), Cell("I2-2-3")]),
          Shelf(3, [Cell("I2-3-1"), Cell("I2-3-2"), Cell("I2-3-3")]),
          Shelf(4, [Cell("I2-4-1"), Cell("I2-4-2"), Cell("I2-4-3")]),
        ])),
    RackGroup(
        10,
        Rack("J1", true,19, [
          Shelf(1, [Cell("J1-1-1"), Cell("J1-1-2"), Cell("J1-1-3")]),
          Shelf(2, [Cell("J1-2-1"), Cell("J1-2-2"), Cell("J1-2-3")]),
          Shelf(3, [Cell("J1-3-1"), Cell("J1-3-2"), Cell("J1-3-3")]),
          Shelf(4, [Cell("J1-4-1"), Cell("J1-4-2"), Cell("J1-4-3")]),
        ]),
        Rack("J2", false,20, [
          Shelf(1, [Cell("J2-1-1"), Cell("J2-1-2"), Cell("J2-1-3")]),
          Shelf(2, [Cell("J2-2-1"), Cell("J2-2-2"), Cell("J2-2-3")]),
          Shelf(3, [Cell("J2-3-1"), Cell("J2-3-2"), Cell("J2-3-3")]),
          Shelf(4, [Cell("J2-4-1"), Cell("J2-4-2"), Cell("J2-4-3")]),
        ])),
    RackGroup(
        11,
        Rack("K1", true, 21,[
          Shelf(1, [Cell("K1-1-1"), Cell("K1-1-2"), Cell("K1-1-3")]),
          Shelf(2, [Cell("K1-2-1"), Cell("K1-2-2"), Cell("K1-2-3")]),
          Shelf(3, [Cell("K1-3-1"), Cell("K1-3-2"), Cell("K1-3-3")]),
          Shelf(4, [Cell("K1-4-1"), Cell("K1-4-2"), Cell("K1-4-3")]),
        ]),
        Rack("K2", false, 22, [
          Shelf(1, [Cell("K2-1-1"), Cell("K2-1-2"), Cell("K2-1-3")]),
          Shelf(2, [Cell("K2-2-1"), Cell("K2-2-2"), Cell("K2-2-3")]),
          Shelf(3, [Cell("K2-3-1"), Cell("K2-3-2"), Cell("K2-3-3")]),
          Shelf(4, [Cell("K2-4-1"), Cell("K2-4-2"), Cell("K2-4-3")]),
        ])),
    RackGroup(
        12,
        Rack("L1", true,23, [
          Shelf(1, [Cell("L1-1-1"), Cell("L1-1-2"), Cell("L1-1-3")]),
          Shelf(2, [Cell("L1-2-1"), Cell("L1-2-2"), Cell("L1-2-3")]),
          Shelf(3, [Cell("L1-3-1"), Cell("L1-3-2"), Cell("L1-3-3")]),
          Shelf(4, [Cell("L1-4-1"), Cell("L1-4-2"), Cell("L1-4-3")]),
        ]),
        Rack("L2", false,24, [
          Shelf(1, [Cell("L2-1-1"), Cell("L2-1-2"), Cell("L2-1-3")]),
          Shelf(2, [Cell("L2-2-1"), Cell("L2-2-2"), Cell("L2-2-3")]),
          Shelf(3, [Cell("L2-3-1"), Cell("L2-3-2"), Cell("L2-3-3")]),
          Shelf(4, [Cell("L2-4-1"), Cell("L2-4-2"), Cell("L2-4-3")]),
        ])),
    /*
    RackGroup(
        Rack("M1", true, [
          Shelf(1, [Cell("M1-1-1"), Cell("M1-1-2"), Cell("M1-1-3")]),
          Shelf(2, [Cell("M1-2-1"), Cell("M1-2-2"), Cell("M1-2-3")]),
          Shelf(3, [Cell("M1-3-1"), Cell("M1-3-2"), Cell("M1-3-3")]),
          Shelf(4, [Cell("M1-4-1"), Cell("M1-4-2"), Cell("M1-4-3")]),
        ]),
        Rack("M2", false, [
          Shelf(1, [Cell("M2-1-1"), Cell("M2-1-2"), Cell("M2-1-3")]),
          Shelf(2, [Cell("M2-2-1"), Cell("M2-2-2"), Cell("M2-2-3")]),
          Shelf(3, [Cell("M2-3-1"), Cell("M2-3-2"), Cell("M2-3-3")]),
          Shelf(4, [Cell("M2-4-1"), Cell("M2-4-2"), Cell("M2-4-3")]),
        ])),
    RackGroup(
        Rack("N1", true, [
          Shelf(1, [Cell("N1-1-1"), Cell("N1-1-2"), Cell("N1-1-3")]),
          Shelf(2, [Cell("N1-2-1"), Cell("N1-2-2"), Cell("N1-2-3")]),
          Shelf(3, [Cell("N1-3-1"), Cell("N1-3-2"), Cell("N1-3-3")]),
          Shelf(4, [Cell("N1-4-1"), Cell("N1-4-2"), Cell("N1-4-3")]),
        ]),
        Rack("N2", false, [
          Shelf(1, [Cell("N2-1-1"), Cell("N2-1-2"), Cell("N2-1-3")]),
          Shelf(2, [Cell("N2-2-1"), Cell("N2-2-2"), Cell("N2-2-3")]),
          Shelf(3, [Cell("N2-3-1"), Cell("N2-3-2"), Cell("N2-3-3")]),
          Shelf(4, [Cell("N2-4-1"), Cell("N2-4-2"), Cell("N2-4-3")]),
        ])),*/
  ];

  List<Area> areas = [
    Area("Z-10", 41),
    Area("Z-09", 40),
    Area("Z-08", 39),
    Area("Z-07", 38),
    Area("Z-06", 37),
    Area("Z-05", 36),
    Area("Z-04", 35),
    Area("Z-03", 34),
    Area("Z-02", 33),
    Area("Z-01", 32),
    Area("", 42),
  ];
}
