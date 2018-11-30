import 'package:event_bus/event_bus.dart';

class EventBusMate   {
   EventBus bus = new EventBus();
  static EventBusMate _instance;
  static EventBusMate getInstance(){
    if(_instance == null){
      _instance = EventBusMate();
    }
    return _instance;
  }
}
 

class SearchPositionEvent{
  final String position;
  SearchPositionEvent(this.position);

}