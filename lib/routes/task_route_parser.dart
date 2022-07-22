import 'dart:convert';

import 'package:flutter/material.dart';


//url to object
class TaskRouteInformationParser extends RouteInformationParser<List<RouteSettings>> {
  const TaskRouteInformationParser() : super();
  
  @override
  Future<List<RouteSettings>> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return Future.value([const RouteSettings(name: '/')]);
    }

    final routeSettings = uri.pathSegments
        .map((pathSegment) => RouteSettings(
              name: '/$pathSegment',
              arguments: pathSegment == uri.pathSegments.last
                  ? uri.queryParameters
                  : null,
            ))
        .toList();

    return Future.value(routeSettings);
  }

  @override
  RouteInformation? restoreRouteInformation(List<RouteSettings> configuration) {
    
    final location = configuration.last.name;
    final arguments = _restoreArguments(configuration.last);
    
    return RouteInformation(location: '$location$arguments');
  }

  String _restoreArguments(RouteSettings routeSettings) {
    if(routeSettings.arguments == null ) return '';
    List<String> queryParameters=['?'];
    (routeSettings.arguments as Map).forEach((key, value) { 
      
      queryParameters.addAll(['&',key,'=',value]);
    });
  
    return queryParameters.join();

  }

}
