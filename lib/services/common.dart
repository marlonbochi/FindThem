import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Common {

  Future<bool> setPreferences (String name, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await prefs.setString(name, value);

      return true;
    } catch(ex) {
      return false;
    }
  }

  Future<dynamic> getPreferences (String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(name);
  }

  Future<bool> removePreferences (String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove(name);
  }
}