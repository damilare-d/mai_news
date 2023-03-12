import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApi {
  final String apiKey = "YOUR_API_KEY_HERE";
  final String baseUrl = "https://newsapi.org/v2/";

  Future<dynamic> getNews(String category) async {
    var response = await http.get(
        "${baseUrl}top-headlines?country=us&category=$category&apiKey=$apiKey");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
