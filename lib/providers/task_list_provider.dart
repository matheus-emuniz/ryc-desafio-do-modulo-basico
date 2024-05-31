import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ryc_desafio_do_modulo_basico/models/task_model.dart';

const String firebaseUrl =
    'ryc-desafio-do-modulo-basico-default-rtdb.firebaseio.com';

class TaskListProvider with ChangeNotifier {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void addTask(TaskModel newTask) async {
    final data = jsonEncode({
      'title': newTask.title,
      'description': newTask.description,
      'date': newTask.date.toString(),
      'completed': newTask.completed,
      'failed': newTask.failed,
    });

    final response = await http.post(
      Uri.https(
        firebaseUrl,
        'tasks.json',
      ),
      body: data,
    );

    final String id = jsonDecode(response.body)['name'];
    newTask.id = id;
    _tasks.add(newTask);

    notifyListeners();
  }

  void completeTask(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);

    if (index < 0) return;

    _tasks[index].completeTask();

    await http.patch(
      Uri.https(firebaseUrl, 'tasks/${_tasks[index].id}/.json'),
      body: jsonEncode({
        'completed': true,
      }),
    );

    notifyListeners();
  }

  void failTask(String taskId) async {
    final task = _tasks.singleWhere((task) => task.id == taskId);

    if (task.failed) {
      return;
    }

    await http.patch(
      Uri.https(firebaseUrl, 'tasks/$taskId/.json'),
      body: jsonEncode({
        'failed': true,
      }),
    );

    task.failTask();
  }

  Future<void> loadTasks() async {
    _tasks.clear();
    final response = await http.get(
      Uri.https(
        firebaseUrl,
        'tasks.json',
      ),
    );

    final data = jsonDecode(response.body);

    if (data == null) return;

    for (var id in data.keys) {
      final task = data[id];
      _tasks.add(TaskModel.fromJson(id, task));
    }

    notifyListeners();
  }
}
