import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {
  static const url =
      "https://www.googleapis.com/books/v1/volumes?q=desarrollo&maxResults=40";

  static const baseUrl = "https://2b7tvpcm-8000.use2.devtunnels.ms";

  static Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(url));
    final result = json.decode(response.body);
    return result['items'];
  }

  static Future<void> getBooks() async {
    final url = Uri.parse("$baseUrl/libros/all/");
    final response = await http.get(url);
    print(response.body);
  }

  static Future<int> createUser(Map data) async {
    final url = Uri.parse("$baseUrl/libros/crear-usuario/");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return (response.statusCode == 201)? 0 : -1;
  }
}
