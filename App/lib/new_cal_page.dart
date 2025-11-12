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

  // Handles day selection on the calendar
  // This provides a two-tier navigation: monthly view for overview, weekly view for details
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!SameDay(_selectedDay!, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

        // Allows users to see event details only when tap on a specific day
        if (_calendarFormat == CalendarFormat.month) {
          _calendarFormat = CalendarFormat.week;
        }
      });
      // Load and display events for the selected day
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
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
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(1999, 1, 1),
            lastDay: DateTime.utc(2099, 12, 31),
            selectedDayPredicate: (day) => _selectedDay != null && SameDay(day, _selectedDay!),
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            onDaySelected: _onDaySelected,
          ),
        ),
        const SizedBox(height: 8.0),
        // Event list only appears in weekly view, not in monthly view
        if (_calendarFormat == CalendarFormat.week)
          Expanded(
            child: ValueListenableBuilder<List<Events>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index].title}'),
                        subtitle: Text('${value[index].description}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
