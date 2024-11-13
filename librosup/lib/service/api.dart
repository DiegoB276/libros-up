import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {
  static const url = "https://www.googleapis.com/books/v1/volumes?q=desarrollo&maxResults=40";

  static Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(url));
    final result = json.decode(response.body);
    return result['items'];
  }
}
 