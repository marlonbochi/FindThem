import 'dart:async';
import 'package:dio/dio.dart';
import 'package:find_them/models/rate.dart';


class RateService {

  Future<bool> create(String token, Rate rate) async {
    var rateConverted = rate.toJson();

    try {
      var response = await Dio().post(
          "https://findthem20190819101129.azurewebsites.net/api/rate",
          data: rateConverted,
          options: new Options(
              headers: { "Authorization": "Bearer " + token}
          )
      );

      if (response.data["success"]) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

}