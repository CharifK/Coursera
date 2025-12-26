import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/time_entry_provider.dart';
import '../dialogs/add_item_dialog.dart';
import '../widgets/main_drawer.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TimeEntryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      drawer: const MainDrawer(),
      body: ListView.builder(
        itemCount: prov.tasks.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(prov.tasks[i].name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => prov.deleteTask(prov.tasks[i].id),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) =>
              AddItemDialog(title: "Add Task", onAdd: prov.addTask),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
