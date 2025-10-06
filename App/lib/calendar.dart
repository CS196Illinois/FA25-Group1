import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Color(0xFF6200EE),
        centerTitle: true,
      ),
      body: const Text("hi"),
    );
  }
}
