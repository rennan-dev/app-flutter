import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import 'http_interceptors.dart';

class AuthService {
  //TODO: modularizar o end point
  static const String url = "http://10.90.51.19:3000/";

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  login({required String email, required String password}) async {
    http.Response response = await client.post(
      Uri.parse('${url}login'),
      body: {
        'email' : email,
        'password' : password
      }
    );
    if(response.statusCode!=200) {
      throw HttpException(response.body);
    }
  }

  register() {

  }
}