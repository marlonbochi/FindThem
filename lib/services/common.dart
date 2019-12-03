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

  Future<bool> testToken() async {

    String token = await getPreferences("token");
    String expirationToken = await getPreferences("token_expiration");

    if (token == null || token.isEmpty){
      return false;
    } else {
      var dateNow = new DateTime.now();
      var dateExpiration = DateTime.parse(expirationToken);

      if (dateExpiration.isBefore(dateNow)) {
        return false;
      } else {
        return true;
      }
    }
  }
}