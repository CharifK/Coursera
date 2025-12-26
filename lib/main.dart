import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'provider/time_entry_provider.dart';
import 'screens/home_screen.dart';
import 'screens/project_management_screen.dart';
import 'screens/task_management_screen.dart';
import 'screens/time_entry_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initLocalStorage();

  runApp(const TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  const TimeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimeEntryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Tracker',
        theme: ThemeData(primarySwatch: Colors.teal),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/projects': (_) => const ProjectManagementScreen(),
          '/tasks': (_) => const TaskManagementScreen(),
          '/add-entry': (_) => const TimeEntryScreen(),
        },
      ),
    );
  }
}