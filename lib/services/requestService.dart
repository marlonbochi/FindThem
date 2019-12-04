import 'dart:async';
import 'package:dio/dio.dart';
import 'package:find_them/models/request.dart';


class RequestService {

  Future<bool> create(String token, Request request) async {

    var requestConverted = request.toJson();

    try {
      var response = await Dio().post(
          "https://findthem20190819101129.azurewebsites.net/api/request/create",
          data: requestConverted,
          options: new Options(
              headers: { "Authorization" : "Bearer " + token}
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

    return true;
  }

  Future<List<Request>> findAll(String token) async {

    var requests = new List<Request>();

    try {
      var response = await Dio().get(
          "https://findthem20190819101129.azurewebsites.net/api/request/findAll",
          options: new Options(
              headers: { "Authorization" : "Bearer " + token}
          )
      );
      response.data.forEach((request) {
        requests.add(Request.fromJson(request));
      });

      return requests;
    } catch (e) {
      print(e);
    }
  }

}