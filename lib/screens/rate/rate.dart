import 'package:flutter/material.dart';

class Rate extends StatefulWidget {
  final int providerID;
  final String token;

  const Rate({Key key, this.token, this.providerID}): super(key: key);

  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  String token = "";
  String nameUser = "";
  void initState() {


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(

        )
    );
  }
}