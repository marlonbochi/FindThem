import 'dart:async';
import 'package:dio/dio.dart';

class API {

    Future<dynamic> signIn(String email, String password) async {

      FormData formData = new FormData.fromMap({
        "login": email,
        "password": password
      });

      try {
        var response = await Dio().post(
          "https://findthem20190819101129.azurewebsites.net/api/login/signIn",
          data: formData
        );
        
        return response.data;
      } catch (e) {
        print(e);
      }
    }

    Future<dynamic> getInformationCEP(String cep) async {

      try {
        var response = await Dio().get(
            "https://viacep.com.br/ws/" + cep + "/json/",
        );

        return response.data;
      } catch (e) {
        print(e);
      }
    }
}