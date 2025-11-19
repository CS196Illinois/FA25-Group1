import 'package:flutter/material.dart';
import 'rso.dart';

class ApplicationFormPage extends StatefulWidget {
  final RSO rso;

  const ApplicationFormPage({super.key, required this.rso});

  @override
  State<ApplicationFormPage> createState() => _ApplicationFormPageState();
}

class _ApplicationFormPageState extends State<ApplicationFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply to ${widget.rso.name}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Application Form - Coming Soon'),
      ),
    );
  }
}
