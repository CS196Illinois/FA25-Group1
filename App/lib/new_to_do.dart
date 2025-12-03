import 'package:flutter/material.dart';
import 'dart:collection';

//import 'package:helloworld/to_do_list.dart';

class NewToDo extends StatelessWidget {
  NewToDo({super.key});

  final TextEditingController subjectInput = new TextEditingController();
  final TextEditingController descriptionInput = new TextEditingController();

  static HashMap<String, Map<String, String>> tasks = HashMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
        backgroundColor: Colors.blue[200],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: subjectInput,
              decoration: InputDecoration(
                hintText: "Enter class/RSO",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[200]!, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 5),
                ),
              ),
            ),
           
            const SizedBox(height: 16),

            TextField(
              controller: descriptionInput,
              decoration: InputDecoration(
                hintText: "Enter task description",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[200]!, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 5),
                ),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[200],
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                //tasks.putIfAbsent(subjectInput.text, () => descriptionInput.text);
                tasks[subjectInput.text] = {
                  "description": descriptionInput.text,
                  "severity": "Low", // default severity
                };
                Navigator.pop(context, true);
              },
              child: Text("Submit")
            ),
          ],
        ),
      ),
    );
  }
}
