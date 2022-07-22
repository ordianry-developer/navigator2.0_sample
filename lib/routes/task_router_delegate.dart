import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models/task_data.dart';
import '../screens/empty_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/task_detail_screen.dart';
import '../screens/task_list_screen.dart';

class TaskRouterDelegate extends RouterDelegate<List<RouteSettings>> with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final _pages = <Page>[];

  AppState appState;
  TaskData taskData;
  // Initializer list
  TaskRouterDelegate(this.appState,this.taskData) : navigatorKey = GlobalKey<NavigatorState>(){
    appState.addListener(() {
      pageActions();
      notifyListeners();
    });
  }
  

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  


  @override
  void dispose() {
    appState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }

  void pageActions() {
    switch (appState.state) {
      case PageState.none:
        //nothing to do
        break;
      case PageState.addPage:
        _pages.add(
          _createPage(
            RouteSettings(
              name: appState.pageName,
              arguments: appState.arguments,
            ),
          ),
        );
        break;
      case PageState.popPage:
        popRoute();
        break;
      default:
    }
    appState.resetCurrentAction();
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget child;
    switch (routeSettings.name) {
      case '/':
        child = const TaskListScreen();
        break;
      case '/${TaskDetailScreen.routeName}':
        try{
          var passedTaskId=(routeSettings.arguments as Map)['taskId'];
          if(int.parse(passedTaskId) >= taskData.taskCount){
            throw 'taskId dosen`t exist';
          } 
          child = TaskDetailScreen(taskId: passedTaskId,);
        } on TypeError catch(_){
          child = EmptyScreen(message:'Wrong Parameter type',);
        } catch(e){
          child = EmptyScreen(message: e.toString(),);
        }
        break;
      case '/${SettingsScreen.routeName}':
        child = SettingsScreen();
        break;
      default:
        child = EmptyScreen();
    }
    return MaterialPage(
      child: child,
      key: ValueKey(routeSettings.toString()),
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) async {
    _setPath(configuration
        .map((routeSettings) => _createPage(routeSettings))
        .toList());
    return Future.value(null);
  }
  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }


  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
    }else{
      appState.popDialog();
    }

    return Future.value(true);
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);

    if (_pages.first.name != '/') {
      _pages.insert(0, _createPage(const RouteSettings(name: '/')));
    }
    notifyListeners();
  }
  bool canPop() {
    return _pages.length > 1;
  }
  
}
