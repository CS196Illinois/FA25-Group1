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
    // Today's events
    normalizeToDay(DateTime.now()): [
      Events("CS124 Lecture", DateTime.now(), "Data structures and algorithms"),
      Events("Lunch with friends", DateTime.now(), "Meet at Chipotle at 12pm"),
      Events("Study Group", DateTime.now(), "Library 3rd floor at 3pm"),
    ],

    // Tomorrow
    normalizeToDay(DateTime.now().add(Duration(days: 1))): [
      Events("Project Meeting", DateTime.now().add(Duration(days: 1)), "Discuss app features with team"),
      Events("Gym", DateTime.now().add(Duration(days: 1)), "Leg day workout"),
    ],

    // Day after tomorrow
    normalizeToDay(DateTime.now().add(Duration(days: 2))): [
      Events("CS124 Assignment Due", DateTime.now().add(Duration(days: 2)), "Submit recursion homework"),
    ],

    // 3 days from now
    normalizeToDay(DateTime.now().add(Duration(days: 3))): [
      Events("RSO Event", DateTime.now().add(Duration(days: 3)), "ACM game night at 7pm"),
      Events("Office Hours", DateTime.now().add(Duration(days: 3)), "Meet TA for help with project"),
    ],

    // 5 days from now
    normalizeToDay(DateTime.now().add(Duration(days: 5))): [
      Events("Weekend Plans", DateTime.now().add(Duration(days: 5)), "Movie night with roommates"),
    ],

    // 7 days from now
    normalizeToDay(DateTime.now().add(Duration(days: 7))): [
      Events("Midterm Exam", DateTime.now().add(Duration(days: 7)), "CS124 midterm - chapters 1-5"),
    ],

    // Specific date example (November 15, 2025)
    normalizeToDay(DateTime.utc(2025, 11, 15)): [
      Events("Career Fair", DateTime.utc(2025, 11, 15), "Bring resume to Activities Building"),
      Events("Dinner", DateTime.utc(2025, 11, 15), "Celebrate birthday at 6pm"),
    ],

    // Another specific date (December 1, 2025)
    normalizeToDay(DateTime.utc(2025, 12, 1)): [
      Events("Final Project Due", DateTime.utc(2025, 12, 1), "Submit completed app with documentation"),
    ],
  };

bool SameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

DateTime normalizeToDay(DateTime date) {
  DateTime normalized = DateTime(date.year, date.month, date.day);
  return normalized;
}
