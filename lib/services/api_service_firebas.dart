import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceFirebase {
  static const String baseUrl =
      'https://movie-list-1eba1-default-rtdb.firebaseio.com';

  Future<List<Movie>> getMovies() async {
    final String url = '$baseUrl/movie/list.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body);
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class Movie {
  final String title;

  Movie({required this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String title = json['title'] ?? 'Unknown Title';

    return Movie(
      title: title,
    );
  }
}
