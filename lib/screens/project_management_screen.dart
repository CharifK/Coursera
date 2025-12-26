import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/time_entry_provider.dart';
import '../dialogs/add_item_dialog.dart';
import '../widgets/main_drawer.dart';

class ProjectManagementScreen extends StatelessWidget {
  const ProjectManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TimeEntryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      drawer: const MainDrawer(),
      body: ListView.builder(
        itemCount: prov.projects.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(prov.projects[i].name),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => prov.deleteProject(prov.projects[i].id),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) =>
              AddItemDialog(title: "Add Project", onAdd: prov.addProject),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
