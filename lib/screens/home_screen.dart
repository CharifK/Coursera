import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../provider/time_entry_provider.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TimeEntryProvider>(context);


    final groupedEntries = groupBy(prov.entries, (e) => e.projectId);

    if (prov.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Time Tracking"),
          backgroundColor: const Color(0xFF009688),
          bottom: const TabBar(
            tabs: [Tab(text: "All Entries"), Tab(text: "Grouped by Projects")],
          ),
        ),
        drawer: const MainDrawer(),
        body: TabBarView(
          children: [
            prov.entries.isEmpty
                ? const Center(child: Text("No time entries yet!"))
                : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: prov.entries.length,
              itemBuilder: (context, i) {
                final entry = prov.entries[i];
                return Card(
                  child: ListTile(
                    title: Text("${entry.projectId} - ${entry.taskId}"),
                    subtitle: Text("Time: ${entry.totalTime} hrs\nNote: ${entry.note}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => prov.deleteEntry(entry.id),
                    ),
                  ),
                );
              },
            ),

            groupedEntries.isEmpty
                ? const Center(child: Text("No projects to group!"))
                : ListView(
              padding: const EdgeInsets.all(8),
              children: groupedEntries.entries.map((group) {
                final projectName = group.key;
                final projectEntries = group.value;

                final double totalTime = projectEntries.fold(0, (sum, item) => sum + item.totalTime);

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    leading: const Icon(Icons.folder, color: Colors.teal),
                    title: Text(
                      projectName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Total: $totalTime hrs (${projectEntries.length} entries)"),
                    children: projectEntries.map((entry) {
                      return ListTile(
                        title: Text(entry.taskId),
                        subtitle: Text("${entry.totalTime} hrs - ${entry.note}"),
                        trailing: Text(
                          "${entry.date.day}/${entry.date.month}",
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFFBC02D),
          child: const Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/add-entry'),
        ),
      ),
    );
  }
}