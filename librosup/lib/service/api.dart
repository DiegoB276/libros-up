import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const baseUrl = "https://2b7tvpcm-8000.use2.devtunnels.ms";

  static Future<List<dynamic>> getData() async {
    final url = Uri.parse("$baseUrl/libros/fetch-books/");
    final response = await http.get(url);
    final result = json.decode(response.body);
    return result['books'];
  }
/*
  static Future<List<dynamic>> getData2() async {
  List<Future<List<dynamic>>> futures = [];

  for (String url in urls) {
    futures.add(_fetchDataFromUrl(url));
  }

  try {
    // Ejecuta todas las solicitudes en paralelo
    final results = await Future.wait(futures);
    // Combina los resultados en un solo arreglo
    final allItems = results.expand((items) => items).toList();
    debugPrint("Total items fetched: ${allItems.length}");
    return allItems;
  } catch (e) {
    debugPrint("Error fetching data: $e");
    return [];
  }
}

static Future<List<dynamic>> _fetchDataFromUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['items'] != null ? List<dynamic>.from(result['items']) : [];
    } else {
      debugPrint("Error: ${response.statusCode} fetching $url");
      return [];
    }
  } catch (e) {
    debugPrint("Exception fetching $url: $e");
    return [];
  }
}
*/

  static Future<List<dynamic>> searchBooks(String booksToSearch) async {
    final url =
        Uri.parse("$baseUrl/libros/recommend-books/?suggestion=$booksToSearch");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return (response.statusCode == 200) ? data['similar_books'] : [];
  }

  static Future<int> createUser(Map data) async {
    final url = Uri.parse("$baseUrl/libros/crear-usuario/");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      return (response.statusCode == 201) ? 0 : -1;
    } catch (error) {
      return -1;
    }
  }

  static Future<int> iniciarSesion(Map data) async {
    final url = Uri.parse("$baseUrl/libros/iniciar-sesion/");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      return (response.statusCode == 200) ? 0 : 1;
    } catch (error) {
      return 1;
    }
  }
}
