import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:helloworld/calendar.dart';
import 'package:helloworld/rso.dart';

class new_cal extends StatefulWidget {
  const new_cal({super.key});

  @override
  State<new_cal> createState() => _new_calState();
}

class _new_calState extends State<new_cal> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: GestureDetector(
                onTap: () {
                  switchview();
                  setState(() {});
                },
                child: const Text("View"),
              ),
            ),
            SizedBox(width: 20),
            Text('Calendar'),
            SizedBox(width: 20),
            SizedBox(
              width: 50,
              height: 30,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: 'My RSOs'),
                    ),
                  );
                },
                child: const Text("+"),
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
