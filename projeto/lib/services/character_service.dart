import 'dart:convert';

import 'package:entregar/components/personagem.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import 'http_interceptors.dart';

class CharacterService {
  static const String url = "http://192.168.51.66:3000/";
  static const String resource = "characters/";

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Personagem personagem) async {
    String jsonPersonagem = json.encode(personagem.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {
        'Content-type': "application/json",
      },
      body: jsonPersonagem,
    );
    if(response.statusCode==201) {
      return true;
    }
    return false;
  }

  Future<String> getCharacters() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }
}