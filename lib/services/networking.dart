import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  final String url;

  NetworkService(this.url);

  Future getData() async {
    http.Response res = await http.get(url);
    var decoded = jsonDecode(res.body);
    return decoded;
  }
}
