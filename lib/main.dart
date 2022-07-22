import 'package:flutter/material.dart';
import 'app_state.dart';
import 'models/task_data.dart';
import 'routes/back_dispatcher.dart';
import 'routes/task_route_parser.dart';
import 'routes/task_router_delegate.dart';
import 'package:provider/provider.dart';

/// navigator2.0 방식이고, routerDelegate 를 적용한 것으로 주소창 입력 URL에 모두 대응한다. 

void main() {
  runApp(TasksApp());
}

class TasksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TasksAppState();
}


class _TasksAppState extends State<TasksApp> {
  final TaskData taskData = TaskData();
  final AppState appState=AppState();
  late TaskRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = TaskRouterDelegate(appState,taskData);
    appState.pushPage(pageName: '');//initial route path 설정
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => taskData),
        ChangeNotifierProvider(create: (_) => appState),
      ],
      builder: (context,_){
        return MaterialApp.router(
          theme: ThemeData(primarySwatch: Colors.deepOrange),
          title: '운동 Check List',
          routerDelegate: _routerDelegate,
          routeInformationParser: TaskRouteInformationParser(),
          backButtonDispatcher: TaskBackButtonDispatcher(_routerDelegate),
        );
      },
    );
  }
}
  
 
