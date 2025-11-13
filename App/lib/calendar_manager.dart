import 'package:flutter/foundation.dart';
import 'rso.dart';

class CalendarManager extends ChangeNotifier {
  static final CalendarManager _instance = CalendarManager._internal();
  factory CalendarManager() => _instance;
  CalendarManager._internal();

  final List<RsoEvent> _events = [];
  List<RsoEvent> get events => List.unmodifiable(_events);

  // ✅ Add a new event (used when saving from FormPage)
  void addEvent(RsoEvent event) {
    _events.add(event);
    notifyListeners(); // updates any listeners (like CalendarPage)
  }

  // ✅ Remove an event
  void removeEvent(RsoEvent event) {
    _events.remove(event);
    notifyListeners();
  }

  // ✅ Optional helper to clear all events
  void clearEvents() {
    _events.clear();
    notifyListeners();
  }

  // 🔁 (optional) keep your existing RSO sync methods if you still use them:
  void addRsoEvents(List<RsoEvent> rsoEvents) {
    for (var e in rsoEvents) {
      if (!_events.contains(e)) {
        _events.add(e);
      }
    }
    notifyListeners();
  }

  void removeRsoEvents(List<RsoEvent> rsoEvents) {
    _events.removeWhere((event) => rsoEvents.contains(event));
    notifyListeners();
  }

  void rebuildEventsFromJoinedRsos(List<RSO> joinedRsos) {
    _events
      ..clear()
      ..addAll(joinedRsos.expand((rso) => rso.events));
    notifyListeners();
  }
}
