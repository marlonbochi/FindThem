import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:find_them/models/request.dart';


class RequestService {

  Future<bool> findAll(String token, Request request) async {

    try {
      var response = await Dio().post(
          "https://findthem20190819101129.azurewebsites.net/api/request/create",
          data: request
      );

      return response.data;
    } catch (e) {
      print(e);
    }
  }
}