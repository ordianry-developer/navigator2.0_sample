import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/task.dart';
import '../models/task_data.dart';
import '../screens/task_detail_screen.dart';
import 'task_checkbox.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  TaskTile({required this.task});
  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: TaskCheckbox(task: widget.task),
        title: Text(
          widget.task.name,
          style: TextStyle(
            decoration: widget.task.isDone ? TextDecoration.lineThrough : null,
            decorationColor: Colors.orange,
            color: Colors.black54,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            widget.task.detail ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              decoration: widget.task.isDone ? TextDecoration.lineThrough : null,
              decorationColor: Colors.orange,
              color: Colors.black54,
            ),
          ),
        ),
        onTap: () {
          //Navigator.pushNamed(context, TaskDetailScreen.routeName,arguments: widget.task.id.toString());
          context.read<AppState>().pushPage(pageName:  TaskDetailScreen.routeName,arguments: {'taskId': widget.task.id.toString()});
        },
        trailing: IconButton(
          onPressed: () {
            context.read<TaskData>().deleteTask(widget.task);
          },
          color: Colors.orange,
          icon: const Icon(
            Icons.delete_outline,
            size: 22,
          ),
        ));
  }
}
