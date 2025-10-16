import 'package:flutter/material.dart';
import 'dart:collection';
import 'form_page.dart';

DateTime now = DateTime.now();
int month = now.month;
int day = now.day;
int year = now.year;
HashMap<int, String> months = HashMap.from({
  1: "Jan.",
  2: "Feb.",
  3: "Mar.",
  4: "Apr.",
  5: "May ",
  6: "Jun.",
  7: "July ",
  8: "Aug.",
  9: "Sept.",
  10: "Oct.",
  11: "Nov.",
  12: "Dec.",
});

class Calendar extends StatefulWidget {
  final ScrollController controller = ScrollController();
  Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  void increaseDate() {
    if (day == 31 &&
        (month == 1 ||
            month == 3 ||
            month == 5 ||
            month == 7 ||
            month == 8 ||
            month == 10 ||
            month == 12)) {
      setState(() {
        day = 1;
        month += 1;
        if (month == 13) {
          month = 1;
          year += 1;
        }
      });
      return;
    } else if (day == 30 &&
        (month == 4 || month == 6 || month == 9 || month == 11)) {
      setState(() {
        day = 1;
        month += 1;
      });
      return;
    } else if (day == 28 && month == 2) {
      setState(() {
        day = 1;
        month += 1;
      });
      return;
    }
    setState(() {
      day += 1;
    });
  }

  void decreaseDate() {
    if (day == 1 && (month == 5 || month == 7 || month == 10 || month == 12)) {
      setState(() {
        day = 30;
        month -= 1;
        if (month == 0) {
          month = 12;
        }
      });
      return;
    } else if (day == 1 &&
        (month == 1 ||
            month == 2 ||
            month == 4 ||
            month == 6 ||
            month == 8 ||
            month == 9 ||
            month == 11)) {
      setState(() {
        day = 31;
        month -= 1;
        if (month == 0) {
          month = 12;
          year -= 1;
        }
      });
      return;
    } else if (day == 0 && month == 3) {
      setState(() {
        day = 28;
        month -= 1;
      });
      return;
    }
    setState(() {
      day -= 1;
    });
  }

  double heigh = 50.0;
  @override
  Widget build(BuildContext context) {
    var currentMonth = months[month]!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("$currentMonth$day, $year"),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed: decreaseDate, child: const Text("<")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: increaseDate, child: const Text(">")),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormPage()),
                );
              },
              child: const Text("+"),
            ),
          ],
        ),
        backgroundColor: Color(0xFF6200EE),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: ScrollController(initialScrollOffset: heigh * 7),
          child: Column(
            children: [
              for (int i = 1; i < 12; i++)
                Container(
                  height: heigh,
                  color: i < 3
                      ? const Color.fromARGB(255, 45, 45, 45)
                      : Colors.blue[(100 * (12 - (i % 12)))],
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${i} AM - ${i + 1} AM",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: i < 3 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              for (int j = 13; j < 21; j++)
                Container(
                  height: heigh,
                  color: Colors.blue[100 * (j % 12) + 100],
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${j - 12} PM - ${j - 11} PM",
                    textAlign: TextAlign.left,
                  ),
                ),
              for (int k = 21; k < 24; k++)
                Container(
                  height: heigh,
                  color: const Color.fromARGB(255, 45, 45, 45),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${k - 12} PM - ${k - 11} PM",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
