import 'package:find_them/screens/request/list.dart';
import 'package:find_them/screens/request/request.dart';
import 'package:flutter/material.dart';
import 'package:find_them/blocprovs/main-bloc-prov.dart';
import 'package:find_them/blocs/main-bloc.dart';
import 'package:find_them/theme/style.dart';
import 'package:find_them/screens/home/home.dart';
import 'package:find_them/screens/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainProvider(
      bloc: MainBloc(),
      child: MaterialApp(
        title: 'Find Them',
        theme: appTheme(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => Home(),
          "/login": (BuildContext context) => Login(),
          "/request": (BuildContext context) => Request(),
          "/listRequest": (BuildContext context) => ListRequest(),
        },
      ),
    );
  }
}