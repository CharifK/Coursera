import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/time_entry_provider.dart';
import '../models/time_entry.dart';

class TimeEntryScreen extends StatefulWidget {
  const TimeEntryScreen({super.key});

  @override
  State<TimeEntryScreen> createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {
  String? selectedProjectId;
  String? selectedTaskId;
  final timeCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  @override
  void dispose() {
    timeCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }

  void _saveEntry(TimeEntryProvider prov) {
    if (selectedProjectId == null || selectedTaskId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a project and a task")),
      );
      return;
    }

    if (timeCtrl.text.isEmpty || double.tryParse(timeCtrl.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid number for hours")),
      );
      return;
    }

    final projectName = prov.projects.firstWhere((p) => p.id == selectedProjectId).name;
    final taskName = prov.tasks.firstWhere((t) => t.id == selectedTaskId).name;

    prov.addEntry(TimeEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      projectId: projectName,
      taskId: taskName,
      date: DateTime.now(),
      totalTime: double.parse(timeCtrl.text),
      note: noteCtrl.text,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TimeEntryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Time Entry")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            DropdownButtonFormField<String>(
              value: selectedProjectId,
              hint: const Text("Select Project"),
              items: prov.projects.map((p) {
                return DropdownMenuItem(value: p.id, child: Text(p.name));
              }).toList(),
              onChanged: (val) => setState(() => selectedProjectId = val),
              decoration: const InputDecoration(labelText: "Project", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),


            DropdownButtonFormField<String>(
              value: selectedTaskId,
              hint: const Text("Select Task"),
              items: prov.tasks.map((t) {
                return DropdownMenuItem(value: t.id, child: Text(t.name));
              }).toList(),
              onChanged: (val) => setState(() => selectedTaskId = val),
              decoration: const InputDecoration(labelText: "Task", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: timeCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Total Time (in hours)", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: noteCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Note", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              onPressed: () => _saveEntry(prov),
              child: const Text("Save Time Entry"),
            )
          ],
        ),
      ),
    );
  }
}