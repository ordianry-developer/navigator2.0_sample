import 'package:flutter/material.dart';
import 'task_router_delegate.dart';

class TaskBackButtonDispatcher extends RootBackButtonDispatcher {
  final TaskRouterDelegate _routerDelegate;

  TaskBackButtonDispatcher(this._routerDelegate): super();


  @override
  Future<bool> didPopRoute() {  
    return _routerDelegate.popRoute();
  }
}
