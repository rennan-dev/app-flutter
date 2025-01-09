import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import 'http_interceptors.dart';

class Webclient {
  static const String url = "http://10.90.51.19:3000/";

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()],
  requestTimeout: const Duration(seconds: 10));

}