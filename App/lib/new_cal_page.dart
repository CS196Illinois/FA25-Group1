import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:helloworld/calendar.dart';
import 'package:helloworld/rso.dart';
import 'package:helloworld/events.dart';

class new_cal extends StatefulWidget {
  const new_cal({super.key});

  @override
  State<new_cal> createState() => _new_calState();
}

class _new_calState extends State<new_cal> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Events>> _selectedEvents;
  void switchview() {
    if (_calendarFormat == CalendarFormat.week) {
      _calendarFormat = CalendarFormat.month;
    } else {
      _calendarFormat = CalendarFormat.week;
    }
  }

  void goToDate(DateTime day, DateTime focusedDay) {
    setState(() {
      now = day;
    });
  }

  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Events> _getEventsForDay(DateTime day) {
    return kEvents[normalizeToDay(day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(232, 119, 34, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {
                  switchview();
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(19, 41, 75, 1),
                ),
                child: Text(
                  "View",
                  style: TextStyle(color: Color.fromRGBO(232, 119, 34, 1)),
                ),
              ),
            ),
            SizedBox(width: 20),
            Text('Calendar'),
            SizedBox(width: 20),
            SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'My RSOs'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(19, 41, 75, 1),
                ),
                child: Text(
                  "+",
                  style: TextStyle(color: Color.fromRGBO(232, 119, 34, 1)),
                ),
              ),
            ),
          ],
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            calendarFormat: _calendarFormat,
            rowHeight: 85,
            focusedDay: now,
            firstDay: DateTime.utc(1999, 1, 1),
            lastDay: DateTime.utc(2099, 12, 31),
            selectedDayPredicate: (day) => isSameDay(day, now),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            onDaySelected: goToDate,
          ),
        ),
      ],
    );
  }
}
