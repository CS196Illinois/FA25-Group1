import 'package:flutter/material.dart';
void main() {
  runApp( MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Color.fromARGB(88, 10, 129, 81),
        centerTitle: true,
      ),
      body: Text("here is the caldenar"),
    )
  ));
}