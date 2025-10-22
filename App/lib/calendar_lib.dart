import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class new_calendar extends StatefulWidget {
  const new_calendar({super.key});

  @override
  State<new_calendar> createState() => _new_calendarState();
}

class _new_calendarState extends State<new_calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Calendar")),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(1999,12,31),
            lastDay: DateTime.utc(2099, 12, 31),
          ),
        ),
      ],
    );
  }
}
