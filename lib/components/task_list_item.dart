import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/components/dialogs.dart';
import 'package:ryc_desafio_do_modulo_basico/models/task_model.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/player_stats_provider.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/task_list_provider.dart';

class TaskListItem extends StatefulWidget {
  final TaskModel task;

  const TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  void initState() {
    super.initState();

    if (widget.task.remainingDays < 0 && !widget.task.failed) {
      context.read<TaskListProvider>().failTask(widget.task.id);
      context.read<PlayerStatsProvider>().loseHealth();
    }
  }

  Color getStatusColor() {
    if (widget.task.completed) {
      return Colors.green;
    }

    if (widget.task.failed) {
      return Colors.red;
    }

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(widget.task.id),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: getStatusColor()),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.task.title, style: TextStyle(
                color: getStatusColor()
              ),),
              subtitle: Text(
                  'Data limite: ${DateFormat('dd/MM/yyyy').format(widget.task.date)}'),
              trailing: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!widget.task.failed && !widget.task.completed)
                      Text('Dias restantes: ${widget.task.remainingDays}'),
                    if (!widget.task.failed && !widget.task.completed)
                      IconButton.outlined(
                        onPressed: () {
                          openConfirmCompleteDialog(context).then(
                            (value) {
                              if (value) {
                                context
                                    .read<TaskListProvider>()
                                    .completeTask(widget.task.id);
                                context.read<PlayerStatsProvider>().addCoins(5);
                              }
                            },
                          );
                        },
                        icon: const Icon(Pixel.check),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.task.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(widget.task.description),
              )
          ],
        ),
      ),
    );
  }
}
