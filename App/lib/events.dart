//import 'package:flutter/material.dart';

class Events {
  String title;
  DateTime date;
  String description;

  Events(this.title, this.date, this.description);
  @override
  String toString() {
    return 'Event(title: $title, date: $date, description: $description)';
  }
}

Map<DateTime, List<Events>> kEvents = {
  normalizeToDay(DateTime.now()): [Events("Today's event", DateTime.now(), "Description"), Events("Another event", DateTime.now(), "Description")],
  normalizeToDay(DateTime.now().add(Duration(days: 1))): [Events("Tomorrow's event", DateTime.now().add(Duration(days: 1)), "Description")],
};

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

DateTime normalizeToDay(DateTime date) {
  DateTime normalized = DateTime(date.year, date.month, date.day);
  return normalized;
}
