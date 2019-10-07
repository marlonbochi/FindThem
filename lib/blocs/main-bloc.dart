import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:find_them/models/contact.dart';
import 'package:flutter/material.dart';

class MainBloc {
  StreamSubscription _audioPlayerStateSubscription;

  Stream<String> get example => _exampleSubject.stream;
  Sink<String> get exampleSink => _exampleSubject.sink;
  final StreamController<String> _exampleSubject = StreamController<String>();

  MainBloc();

  void dispose() {
    _exampleSubject.close();  
  }
}