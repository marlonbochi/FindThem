import 'package:flutter/material.dart';
import 'package:find_them/blocs/main-bloc.dart';

class MainProvider extends InheritedWidget {
  final MainBloc bloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MainBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MainProvider) as MainProvider).bloc;
  }

  MainProvider({Key key, this.bloc, Widget child}) : super(child: child, key: key);
}