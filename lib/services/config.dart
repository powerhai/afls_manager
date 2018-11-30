import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const ShelfCountKey = "ShelfCount";
  static const String CellCountKey = "CellCount";
  static const String PrinterKey = "Printer";
  static const String SteelyardKey = "Steelyard";
  static const String ForceMoveKey = "ForceMoveKey";
  SharedPreferences _localDb;
 
  static Config _instance;

  int shelfCount;

  int cellCount;

  String steelyard;

  String printer;
  bool forceMove;
  void saveForceMove(bool v){
    this.forceMove = v;
    _localDb.setBool(ForceMoveKey, v);
  }

  void saveShelfCount(int v){
    this.shelfCount = v;
    _localDb.setInt(ShelfCountKey, v);
  }
  void saveCellCount(int v){
    this.cellCount = v;
    _localDb.setInt(CellCountKey, v);
  }
  void saveSteelyard(String v){
    this.steelyard = v;
    _localDb.setString(SteelyardKey, v);
  }
  void savePrinter(String v){
    this.printer = v;
    _localDb.setString(PrinterKey, v);
  }

  static Config getInstance() {
    if (_instance == null) {
      _instance = Config();
    }

    return _instance;
  }

  Future load() async {
    if (_localDb == null) {
      _localDb = await SharedPreferences.getInstance();
      this.shelfCount = _localDb.getInt(ShelfCountKey);
      this.cellCount = _localDb.getInt(CellCountKey);
      this.steelyard = _localDb.getString(SteelyardKey);
      this.printer = _localDb.getString(PrinterKey);
    }
  }
}
