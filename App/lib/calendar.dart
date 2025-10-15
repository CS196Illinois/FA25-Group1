import 'package:flutter/material.dart';

DateTime now = DateTime.now();
int month = now.month;
int day = now.day;

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  void increaseDate() {
    setState(() {
      day += 1;
    });
  }

  void decreaseDate() {
    setState(() {
      day -= 1;
    });
  }

  double heigh = 50.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Date: $month/$day"),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed: decreaseDate, child: const Text("<")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: increaseDate, child: const Text(">")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: () {}, child: const Text("+")),
          ],
        ),
        backgroundColor: Color(0xFF6200EE),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            for (int i = 1; i < 12; i++)
              Container(
                height: heigh,
                color: i < 3? const Color.fromARGB(255, 45, 45, 45): Colors.blue[100 * (i % 12) - 200],
                alignment: Alignment.centerLeft,
                child: Text("${i} AM - ${i + 1} AM", textAlign: TextAlign.left, style: TextStyle(color: i < 3? Colors.white: Colors.black)),
              ),
            for (int j = 13; j < 24; j++)
              Container(
                height: heigh, 
                color: Colors.orange[100 * (j % 12)],
                alignment: Alignment.centerLeft,
                child: Text("${j - 12} PM - ${j - 11} PM", textAlign: TextAlign.left,),
              )
          ],)
        )
      ),
    );
  }
}
