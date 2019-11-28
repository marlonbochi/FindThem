import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:find_them/models/provider.dart';
import 'package:find_them/models/service.dart';


class ServiceService {

  Future<List<Service>> findAll(String token, int providerID) async {

    var services = new List<Service>();

    try {
      Response response = await Dio().get(
          "https://findthem20190819101129.azurewebsites.net/api/service/findAll/" + providerID.toString(),
          options: new Options(
              headers: { "Authorization" : "Bearer " + token}
          )
      );

      response.data.forEach((service) {
        services.add(Service.fromJson(service));
      });

      return services;
    } catch (e) {
      print(e);
    }
  }
}