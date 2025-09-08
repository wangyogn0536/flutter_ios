// ignore: depend_on_referenced_packages
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class PointChange {
  String point;
  PointChange(this.point);
}
