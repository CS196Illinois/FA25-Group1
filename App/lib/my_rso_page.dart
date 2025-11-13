/*
import 'package:flutter/material.dart';
import 'rso.dart';

class MyRSOPage extends StatelessWidget {
  final List<RSO> joinedRSOs;

  const MyRSOPage({super.key, required this.joinedRSOs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My RSOs')),
      body: joinedRSOs.isEmpty
          ? const Center(child: Text('You have not joined any RSOs yet.'))
          : ListView.builder(
              itemCount: joinedRSOs.length,
              itemBuilder: (context, index) {
                final rso = joinedRSOs[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.orange[100],
                  child: ListTile(
                    title: Text(rso.name, style: const TextStyle(fontSize: 20)),
                    subtitle: Text(rso.description),
                  ),
                );
              },
            ),
    );
  }
}
*/

// lib/my_rso_page.dart
import 'package:flutter/material.dart';
import 'rso.dart';

class MyRSOPage extends StatelessWidget {
  final List<RSO> joinedRSOs;

  const MyRSOPage({super.key, required this.joinedRSOs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My RSOs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: joinedRSOs.isEmpty
          ? const Center(
              child: Text(
                'You have not joined any RSOs yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: joinedRSOs.length,
              itemBuilder: (context, index) {
                final rso = joinedRSOs[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.orange[100],
                  child: ExpansionTile(
                    title: Text(
                      rso.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(rso.description),
                    children: [
                      // ✅ Show all upcoming events for that RSO
                      if (rso.events.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("No upcoming events."),
                        )
                      else
                        ...rso.events.map((event) => ListTile(
                              leading: const Icon(Icons.event),
                              title: Text(event.title),
                              subtitle: Text(
                                "${event.startTime} - ${event.endTime}\n${event.description}",
                              ),
                            )),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
