import 'package:flutter/material.dart';

enum PageState {
  none,
  addPage,
  popPage,
}

class AppState extends ChangeNotifier {
  String? _pageName;
  Object? _arguments;
  PageState _state=PageState.none;
  BuildContext? _dialogContext;

  get pageName => _pageName;
  get arguments => _arguments;
  get state => _state;

  void pushPage({required String? pageName, Object? arguments, PageState state=PageState.addPage,}) {
    _pageName = '/$pageName';
    _arguments = arguments;
    _state = state;
    notifyListeners();
  }

  void popPage() {
    _state = PageState.popPage;
    notifyListeners();
  }

  void resetCurrentAction() {
    _state = PageState.none;
    _pageName=_arguments=null;
  }

  set dialogContext(BuildContext dialogCtx){
    _dialogContext=dialogCtx;
  }

  void popDialog(){
    if(_dialogContext != null){
      Navigator.pop(_dialogContext!);
      _dialogContext=null;
    }
  }
}