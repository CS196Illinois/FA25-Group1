import 'package:flutter/material.dart';
import 'package:helloworld/new_to_do.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  // Severity options
  final List<String> severityLevels = ["Low", "Medium", "High"];

  // Severity and corresponding colors
  Color _severityColor(String severity) {
    switch (severity) {
      case "Low":
        return Colors.green[300]!;
      case "Medium":
        return Colors.orange[300]!;
      case "High":
        return Colors.red[300]!;
      default:
        return Colors.blue[200]!;
    }
  }

  Future<void> refresh() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewToDo()),
    );
    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskEntries = NewToDo.tasks.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List"),
        backgroundColor: Colors.blue[200],
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: taskEntries.length,
        itemBuilder: (context, index) {
          final entry = taskEntries[index];
          final taskTitle = entry.key;
          final taskData = entry.value;

          final severity = taskData["severity"]!;
          final description = taskData["description"]!;
          final containerColor = _severityColor(severity);

          return Container(
            height: 140,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 3),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  spreadRadius: 5,
                )
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$taskTitle\n$description",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // Severity Dropdown
                DropdownButton<String>(
                  value: severity,
                  dropdownColor: containerColor,
                  items: severityLevels.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      NewToDo.tasks[taskTitle]!["severity"] = newValue!;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        onPressed: refresh,
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}

