/*
import 'package:flutter/material.dart';
import 'package:helloworld/calendar_page.dart';
import 'form_page.dart';

class RsoListPage extends StatefulWidget {
  const RsoListPage({super.key});

  @override
  State<RsoListPage> createState() => _RsoListPageState();
}

class _RsoListPageState extends State<RsoListPage> {
  // sample RSO data
  final List<Map<String, dynamic>> _rsos = [
    {"name": "Society of Women Engineers", "joined": false},
    {"name": "ACM SIGARCH", "joined": false},
    {"name": "Engineers Without Borders", "joined": false},
    {"name": "Illini Solar Car", "joined": false},
    {"name": "Open Source @ Illinois", "joined": false},
    {"name": "Jewelry Making Club", "joined": false},
  ];

  List<Map<String, dynamic>> get joinedRsos =>
      _rsos.where((r) => r["joined"] == true).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All RSOs"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: "My RSOs",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyRsoPage(joinedRsos: joinedRsos),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _rsos.length,
        itemBuilder: (context, index) {
          final rso = _rsos[index];
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.blue[100],
            child: ListTile(
              title: Text(rso["name"]),
              subtitle: const Text("*Include detailed description here*"),
              trailing: Switch(
                value: rso["joined"],
                activeColor: Colors.orange,
                onChanged: (bool val) {
                  setState(() {
                    rso["joined"] = val;
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      
    );
  }
}

class MyRsoPage extends StatelessWidget {
  final List<Map<String, dynamic>> joinedRsos;
  const MyRsoPage({super.key, required this.joinedRsos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My RSOs"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: joinedRsos.isEmpty
          ? const Center(child: Text("You haven't joined any RSOs yet."))
          : ListView.builder(
              itemCount: joinedRsos.length,
              itemBuilder: (context, index) {
                final rso = joinedRsos[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: Colors.orange[100],
                  child: ListTile(
                    title: Text(rso["name"]),
                    subtitle: const Text("*RSO description here*"),
                  ),
                );
              },
            ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:helloworld/calendar_manager.dart';
import 'package:helloworld/calendar_page.dart';
import 'rso.dart';
import 'my_rso_page.dart';
import 'application_form_page.dart';

class RsoListPage extends StatefulWidget {
  const RsoListPage({super.key});

  @override
  State<RsoListPage> createState() => _RsoListPageState();
}

class _RsoListPageState extends State<RsoListPage> {
  late final List<RSO> _rsos;
  late final User _currentUser;

  @override
  void initState() {
    super.initState();

    // ✅ Define RSOs first, then link events back to their parent RSO
    _rsos = [
      RSO(
        name: "Society of Women Engineers (SWE)",
        description: "Empowering women in engineering through networking, mentorship, and events.",
        events: [],
      ),
      RSO(
        name: "Open Source @ Illinois",
        description: "Collaborate on open-source software projects with peers and mentors.",
        events: [],
      ),
      RSO(
        name: "WCS: Women in Computer Science",
        description: "Supporting women and minorities in computer science through mentorship and events.",
        events: [],
      ),
      RSO(
        name: "Project Code",
        description: "Hands-on coding projects for social good — open to all skill levels.",
        events: [],
      ),
      RSO(
        name: "Hack for Impact",
        description: "Develop tech solutions for nonprofits through hackathons and collaborations.",
        events: [],
      ),
      RSO(
        name: "Illinois Business Consulting (IBC)",
        description: "Work on real consulting projects for clients across industries.",
        events: [],
      ),
      RSO(
        name: "Champaign-Urbana Business and Engineering (CUBE)",
        description: "Fusing business strategy with technical innovation.",
        events: [],
      ),
      RSO(
        name: "Accounting Club",
        description: "Connecting accounting students with firms and professionals.",
        events: [],
      ),
      RSO(
        name: "ACM: Association for Computing Machinery",
        description: "The premier computer science club at UIUC for workshops, talks, and competitions.",
        events: [],
      ),
    ];

    // ✅ Now add sample events to each, and back-reference RSO
    _rsos[0].events.addAll([
      RsoEvent(
        title: "SWE General Meeting",
        description: "Monthly networking and announcements.",
        location: "ECEB 3015",
        startTime: DateTime(2025, 11, 10, 17, 0),
        endTime: DateTime(2025, 11, 10, 18, 0),
        rso: _rsos[0],
      ),
      RsoEvent(
        title: "Resume Workshop",
        description: "Refine your resume with SWE mentors.",
        location: "ECEB 1010",
        startTime: DateTime(2025, 11, 20, 16, 0),
        endTime: DateTime(2025, 11, 20, 17, 30),
        rso: _rsos[0],
      ),
    ]);

    _rsos[1].events.addAll([
      RsoEvent(
        title: "Hack Night",
        description: "Collaborative open-source coding session.",
        location: "Siebel 2405",
        startTime: DateTime(2025, 12, 3, 18, 0),
        endTime: DateTime(2025, 12, 3, 21, 0),
        rso: _rsos[1],
      ),
    ]);

    _rsos[2].events.addAll([
      RsoEvent(
        title: "WCS Networking Night",
        description: "Meet women leaders in tech and UIUC alumni.",
        location: "Siebel Atrium",
        startTime: DateTime(2025, 12, 5, 17, 30),
        endTime: DateTime(2025, 12, 5, 19, 0),
        rso: _rsos[2],
      ),
    ]);

    _rsos[3].events.addAll([
      RsoEvent(
        title: "Project Showcase",
        description: "Present your coding projects to other members.",
        location: "Grainger Library 404",
        startTime: DateTime(2025, 11, 25, 15, 0),
        endTime: DateTime(2025, 11, 25, 17, 0),
        rso: _rsos[3],
      ),
    ]);

    _rsos[4].events.addAll([
      RsoEvent(
        title: "Hack for Nonprofits",
        description: "Weekend hackathon to build tech for social good.",
        location: "Siebel Center 1404",
        startTime: DateTime(2025, 12, 10, 9, 0),
        endTime: DateTime(2025, 12, 10, 18, 0),
        rso: _rsos[4],
      ),
    ]);

    _rsos[5].events.addAll([
      RsoEvent(
        title: "IBC Kickoff Meeting",
        description: "Welcome session for new consultants.",
        location: "BIF 3009",
        startTime: DateTime(2025, 11, 14, 18, 0),
        endTime: DateTime(2025, 11, 14, 19, 30),
        rso: _rsos[5],
      ),
    ]);

    _rsos[6].events.addAll([
      RsoEvent(
        title: "CUBE Strategy Night",
        description: "Workshop on tech-driven business strategy.",
        location: "ECEB 2003",
        startTime: DateTime(2025, 11, 22, 16, 0),
        endTime: DateTime(2025, 11, 22, 18, 0),
        rso: _rsos[6],
      ),
      RsoEvent(
        title: "CUBE Networking Fiesta",
        description: "Come network with fellow strategists!!.",
        location: "MCB 2003",
        startTime: DateTime(2025, 11, 22, 14, 0),
        endTime: DateTime(2025, 11, 22, 16, 0),
        rso: _rsos[6],
      ),
    ]);

    _rsos[7].events.addAll([
      RsoEvent(
        title: "Accounting Career Fair",
        description: "Meet recruiters and learn about internships.",
        location: "BIF Atrium",
        startTime: DateTime(2025, 11, 18, 10, 0),
        endTime: DateTime(2025, 11, 18, 14, 0),
        rso: _rsos[7],
      ),
    ]);

    _rsos[8].events.addAll([
      RsoEvent(
        title: "ACM Coding Competition",
        description: "Compete in an algorithmic challenge.",
        location: "Siebel 1109",
        startTime: DateTime(2025, 12, 1, 17, 0),
        endTime: DateTime(2025, 12, 1, 20, 0),
        rso: _rsos[8],
      ),
    ]);

    // ✅ Initialize current user with empty joined RSOs list
    _currentUser = User(
      username: "student@illinois.edu",
      passkey: "password123",
      joinedRsos: [],
    );
  }

  List<RSO> get joinedRsos => _rsos.where((rso) => rso.isMember).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All RSOs"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: "My RSOs",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyRSOPage(joinedRSOs: joinedRsos),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _rsos.length,
        itemBuilder: (context, index) {
          final rso = _rsos[index];
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.blue[100],
            child: ListTile(
              title: Text(rso.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(rso.description),
              trailing: Switch(
                value: rso.isMember,
                activeThumbColor: Colors.orange,
                onChanged: (bool val) {
                  // Check if switching ON and user is NOT in this RSO
                  if (val && !_currentUser.joinedRsos.contains(rso)) {
                    // Navigate to application form page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationFormPage(rso: rso),
                      ),
                    );
                  } else {
                    // Normal toggle behavior
                    setState(() {
                      rso.isMember = val;
                      if (val) {
                        CalendarManager().addRsoEvents(rso.events);
                      } else {
                        CalendarManager().removeRsoEvents(rso.events);
                      }
                    });
                  }
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalendarPage()),
          );
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }
}
