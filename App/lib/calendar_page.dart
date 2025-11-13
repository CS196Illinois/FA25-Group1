
/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'calendar_manager.dart';
import 'rso.dart';
import 'form_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    CalendarManager().addListener(_refresh);
  }

  void _refresh() => setState(() {});

  void _navigateToAddEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );
  }


  @override
  void dispose() {
    CalendarManager().removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = CalendarManager().events;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My RSO Calendar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: _refresh,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add Event",
            onPressed: _navigateToAddEvent,
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        allowedViews: const [
          CalendarView.month,
          CalendarView.week,
          CalendarView.day,
          CalendarView.schedule,
        ],
        dataSource: _RsoCalendarDataSource(events),
        showNavigationArrow: true,
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          agendaItemHeight: 70,
        ),
        onTap: (details) {
          if (details.appointments != null && details.appointments!.isNotEmpty) {
            final event = details.appointments!.first as RsoEvent;
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(event.title),
                content: Text(
                  "RSO: ${event.rso.name}\n"
                  "Location: ${event.location}\n\n"
                  "${event.description}",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _RsoCalendarDataSource extends CalendarDataSource {
  _RsoCalendarDataSource(List<RsoEvent> events) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].startTime;

  @override
  DateTime getEndTime(int index) => appointments![index].endTime;

  @override
  String getSubject(int index) {
    final event = appointments![index] as RsoEvent;
    return "${event.title} (${event.rso.name})";
  }

  @override
  String? getLocation(int index) {
    final event = appointments![index] as RsoEvent;
    return event.location;
  }

  @override
  Color getColor(int index) {
    final event = appointments![index] as RsoEvent;
    final hash = event.rso.name.hashCode;
    return Colors.primaries[hash % Colors.primaries.length];
  }
}

*/

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'calendar_manager.dart';
import 'rso.dart';
import 'form_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final CalendarManager _manager;

  @override
  void initState() {
    super.initState();
    _manager = CalendarManager();
    _manager.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _manager.removeListener(_refresh);
    super.dispose();
  }

  Future<void> _navigateToAddEvent() async {
    final newEvent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormPage()),
    );

    if (newEvent != null && newEvent is RsoEvent) {
      _manager.addEvent(newEvent); // add to calendar
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = _manager.events;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My RSO Calendar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: _refresh,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add Event",
            onPressed: _navigateToAddEvent,
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        allowedViews: const [
          CalendarView.month,
          CalendarView.week,
          CalendarView.day,
          CalendarView.schedule,
        ],
        dataSource: _RsoCalendarDataSource(events),
        showNavigationArrow: true,
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          agendaItemHeight: 70,
        ),
        onTap: (details) {
          if (details.appointments != null && details.appointments!.isNotEmpty) {
            final event = details.appointments!.first as RsoEvent;
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(event.title),
                content: Text(
                  "RSO: ${event.rso.name}\n"
                  "Location: ${event.location}\n\n"
                  "${event.description}",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _RsoCalendarDataSource extends CalendarDataSource {
  _RsoCalendarDataSource(List<RsoEvent> events) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].startTime;
  @override
  DateTime getEndTime(int index) => appointments![index].endTime;
  @override
  String getSubject(int index) {
    final event = appointments![index] as RsoEvent;
    return "${event.title} (${event.rso.name})";
  }

  @override
  String? getLocation(int index) =>
      (appointments![index] as RsoEvent).location;

  @override
  Color getColor(int index) {
    final event = appointments![index] as RsoEvent;
    final hash = event.rso.name.hashCode;
    return Colors.primaries[hash % Colors.primaries.length];
  }
}
