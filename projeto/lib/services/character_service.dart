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

  register(String content) {
    client.post(Uri.parse(getUrl()), body: {
      "content": content
    });
  }

  Future<String> getCharacters() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print(response.body);
    return response.body;
  }
}