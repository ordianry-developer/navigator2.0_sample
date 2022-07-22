import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/task.dart';
import '../models/task_data.dart';
import '../routes/task_router_delegate.dart';
import '../widgets/task_list.dart';
import 'add_task_screen.dart';
import 'settings_screen.dart';

class TaskListScreen extends StatefulWidget {
  static const routeName = 'task_list_screen';
  final List<Task>? tasks;
  final ValueChanged<Task>? onTapped;

  const TaskListScreen({super.key, this.tasks, this.onTapped});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Widget buildBottomSheet(BuildContext context) {
    return AddTaskScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu_outlined),
          onPressed: () {
            //Navigator.pushNamed(context, SettingsScreen.routeName);
            context.read<AppState>().pushPage(pageName: SettingsScreen.routeName);
          },
        ),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
        title: Text("운동 List (${Provider.of<TaskData>(context).taskCount}개)"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/runningbackground.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 00.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t be lazy!!',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TaskList(),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                //decoration:  BoxDecoration(color: Colors.orange[100]),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[900],
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
                context.read<AppState>().dialogContext = context;
                return Dialog(
                backgroundColor: Colors.transparent,
                child: AddTaskScreen(),
              );
            }
          );
          
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
