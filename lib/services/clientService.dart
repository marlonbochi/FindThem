import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:find_them/models/client.dart';


class ClientService {

  Future<Client> get(String token) async {

    try {
      Response response = await Dio().get(
          "https://findthem20190819101129.azurewebsites.net/api/client",
          options: new Options(
              headers: { "Authorization" : "Bearer " + token}
          )
      );

      var client = Client.fromJson(response.data);

      return client;
    } catch (e) {
      print(e);
    }
  }
}