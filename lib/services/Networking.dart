import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String URL;

  NetworkHelper(this.URL);

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Future.error('Somthing Wrong');
    }
  }
}
