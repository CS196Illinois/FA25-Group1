import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
DateTime now = DateTime.now();
String month = DateFormat('MMMM').format(now);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Date: $month $day"),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed: decreaseDate, child: const Text("<")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: increaseDate, child: const Text(">")),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: (){}, child: const Text("+"))
          ],
        ),
        backgroundColor: Color(0xFF6200EE),
        centerTitle: true,
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            color: Colors.blue[000],
            alignment: Alignment.center,
            child: Text("12 AM - 1 AM ", style: TextStyle(textBaseline: TextBaseline.ideographic)), 
          ),
          Container(
            height: 50,
            color: Colors.blue[100],
            alignment: Alignment.center,
            child: Text("1 AM - 2 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[200],
            alignment: Alignment.center,
            child: Text("2 Am - 3 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[300],
            alignment: Alignment.center,
            child: Text("3 Am - 4 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[400],
            alignment: Alignment.center,
            child: Text("4 Am - 5 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[500],
            alignment: Alignment.center,
            child: Text("5 Am - 6 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[600],
            alignment: Alignment.center,
            child: Text("6 Am - 7 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[700],
            alignment: Alignment.center,
            child: Text("7 Am - 8 AM", style: TextStyle()), 
          ),
          Container(
            height: 50,
            color: Colors.blue[800],
            alignment: Alignment.center,
            child: Text("8 Am - 9 AM", style: TextStyle()), 
          ),
        ]
      )
    );
  }
}
