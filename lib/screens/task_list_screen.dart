import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/components/empty_task_list.dart';
import 'package:ryc_desafio_do_modulo_basico/components/task_list_item.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/task_list_provider.dart';
import 'package:ryc_desafio_do_modulo_basico/utils/app_routes.dart';
import 'package:ryc_desafio_do_modulo_basico/utils/focus.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _titleController = TextEditingController();

  bool _loadingTasks = true;

  void _getTasks() async {
    await context.read<TaskListProvider>().loadTasks();
    setState(() {
      _loadingTasks = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskListProvider = context.watch<TaskListProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    labelText: 'Nova tarefa',
                    hintText: 'Título',
                  ),
                  controller: _titleController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.register,
                        arguments: _titleController.text);
                    _titleController.text = '';
                    clearFocus(context);
                  },
                  icon: const Icon(
                    Pixel.plus,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    highlightColor: Colors.black12,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_loadingTasks)
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/loading_gif.gif',
                width: 70,
                height: 70,
              ),
            ),
          ),
        if (taskListProvider.tasks.isNotEmpty && !_loadingTasks)
          Expanded(
            child: ListView.builder(
              itemCount: taskListProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskListProvider.tasks[index];
                return TaskListItem(
                  task: task,
                );
              },
            ),
          ),
        if (taskListProvider.tasks.isEmpty && !_loadingTasks)
          const Expanded(
            child: EmptyTaskList(),
          ),
      ],
    );
  }
}
