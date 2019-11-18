import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:find_them/models/provider.dart';


class ProviderService {

  Future<List<Provider>> findAll(String token) async {

    var providers = new List<Provider>();

    try {
      Response response = await Dio().get(
          "https://findthem20190819101129.azurewebsites.net/api/provider/findAll",
          options: new Options(
              headers: { "Authorization" : "Bearer " + token}
          )
      );

      response.data.forEach((provider) {
        providers.add(Provider.fromJson(provider));
      });

      return providers;
    } catch (e) {
      print(e);
    }
  }

  Future<Provider> get(String token, int providerId) async {

    try {
      Response response = await Dio().get(
          "https://findthem20190819101129.azurewebsites.net/api/provider/" + providerId.toString(),
          options: new Options(
              headers: { "Authorization" : "Bearer " + token}
          )
      );

      var provider = Provider.fromJson(response.data);

      return provider;
    } catch (e) {
      print(e);
    }
  }

}