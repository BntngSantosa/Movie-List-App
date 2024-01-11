import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '3a5faeebfadfb933db7de44040f0ff0c';

  Future<List<Movie>> getMovies() async {
    final String url = '$baseUrl/movie/popular?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieTopRated>> getMoviesTopRated() async {
    final String url = '$baseUrl/movie/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieTopRated.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieTrending>> getMoviesTrending() async {
    final String url = '$baseUrl/trending/movie/day?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieTrending.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieUpComing>> getMoviesUpComing() async {
    final String url = '$baseUrl/movie/upcoming?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => MovieUpComing.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class Movie {
  final String title;
  final String posterPath;
  final String releaseDate;

  Movie({required this.title, required this.posterPath, required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {

    final formattedDate = DateFormat('MMMM d, y').format(DateTime.parse(json['release_date']));

    return Movie(
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: formattedDate,
    );
  }
}

class MovieTopRated {
  final String title;
  final String posterPath;

  MovieTopRated({required this.title, required this.posterPath});

  factory MovieTopRated.fromJson(Map<String, dynamic> json) {

    return MovieTopRated(
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}

class MovieTrending{
  final String title;
  final String posterPath;

  MovieTrending({required this.title, required this.posterPath});

  factory MovieTrending.fromJson(Map<String, dynamic> json) {
    return MovieTrending(
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}

class MovieUpComing{
  final String title;
  final String posterPath;

  MovieUpComing({required this.title, required this.posterPath});

  factory MovieUpComing.fromJson(Map<String, dynamic> json) {
    return MovieUpComing(
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}