class BluePrinter {
  static BluePrinter _instance;
  static BluePrinter getInstance() {
    if (_instance == null) {
      _instance = BluePrinter();
    }
    return _instance;
  }

  BluePrinter() {}
  bool _connected = false;
  bool get connected {
    return _connected;
  }

  void init() {}
  void connect() {
    _connected = true;
  }
}
 