import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../models/time_entry.dart';

class TimeEntryProvider with ChangeNotifier {
  List<Project> _projects = [];
  List<Task> _tasks = [];
  List<TimeEntry> _entries = [];
  bool _isLoading = true;

  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;
  List<TimeEntry> get entries => _entries;
  bool get isLoading => _isLoading;

  TimeEntryProvider() {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    await Future.delayed(Duration.zero);

    _isLoading = true;

    try {
      final pData = localStorage.getItem('projects');
      final tData = localStorage.getItem('tasks');
      final eData = localStorage.getItem('timeEntries');

      if (pData != null) {
        _projects = (json.decode(pData) as List)
            .map((i) => Project.fromJson(i))
            .toList();
      }
      if (tData != null) {
        _tasks = (json.decode(tData) as List)
            .map((i) => Task.fromJson(i))
            .toList();
      }
      if (eData != null) {
        _entries = (json.decode(eData) as List)
            .map((i) => TimeEntry.fromJson(i))
            .toList();
      }
    } catch (e) {
      debugPrint("Error loading from storage: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _saveToStorage() {
    localStorage.setItem('projects', json.encode(_projects));
    localStorage.setItem('tasks', json.encode(_tasks));
    localStorage.setItem('timeEntries', json.encode(_entries));
  }

  void addProject(String name) {
    _projects.add(Project(
        id: DateTime.now().millisecondsSinceEpoch.toString(), name: name));
    _saveToStorage();
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void addTask(String name) {
    _tasks.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), name: name));
    _saveToStorage();
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void addEntry(TimeEntry entry) {
    _entries.add(entry);
    _saveToStorage();
    notifyListeners();
  }

  void deleteEntry(String id) {
    _entries.removeWhere((e) => e.id == id);
    _saveToStorage();
    notifyListeners();
  }
}