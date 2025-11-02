import 'package:flutter/material.dart';

class new_cal extends StatefulWidget {
  const new_cal({super.key});

  @override
  State<new_cal> createState() => _new_calState();
}

class _new_calState extends State<new_cal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Calendar Page'),
      ),
      body: const Center(
        child: Text('This is the new calendar page.'),
      ),
    );
  }
}