import 'package:afls_manager/models/position.dart';

class VehichleShelf {
  int shelf;
  List<VehichleCell> cells;
  VehichleShelf(this.shelf, this.cells);
}

class VehichleCell {
  List<BillGoods> goods = [];
  bool get pickFinished {
    return !goods.any((a) {
      return a.needPickCount != a.pickedCount;
    });
  }

  bool get pickFailed {
    return goods.any((a) {
      return a.pickFailed;
    });
  }

  bool get picking {
    var finish = goods.any((a) {
      return   a.pickedCount == a.needPickCount;
    });
    var nofinish = goods.any((a){
      return a.pickedCount < a.needPickCount;
    });
    return finish == true && nofinish == true;
  }

  int get needPickCount {
    int c = 0;
    for (BillGoods b in goods) {
      c += b.needPickCount;
    }
    return c;
  }

  bool get needPick {
    return goods.length > 0;
  }

  int no;
  VehichleCell(this.no);
}

class Vehichle {
  int no;
  int cellCount;
  int shelfCount;
  List<VehichleShelf> shelves = [];
  Vehichle(this.no, this.shelfCount, this.cellCount) {
    for (int s = 0; s < this.shelfCount; s++) {
      List<VehichleCell> cs = [];
      for (int c = 0; c < this.cellCount; c++) {
        cs.add(new VehichleCell(
            ((no) * shelfCount * cellCount) + (s) * cellCount + c + 1));
      }
      var shelf = VehichleShelf(s, cs);
      shelves.add(shelf);
    }
  }
}
