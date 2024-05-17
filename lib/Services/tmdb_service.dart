import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/Models/movie.dart';

class TMDBService {
  static const apiKey = '31521ab741626851b73c684539c33b5a';
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const username = 'johnny_appleseed';
  static const password = 'test123';

  Future<String?> createRequestToken() async {
    final response = await http.get(
      Uri.parse('$baseUrl/authentication/token/new?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['request_token'];
      return token;
    } else {
      throw Exception('Failed to create request token');
    }
  }
  Future<bool> validateRequestToken(String requestToken) async {
    final body = json.encode({
      'username': username,
      'password': password,
      'request_token': "1531f1a558c8357ce8990cf887ff196e8f5402ec",
    });

    final response = await http.post(
      Uri.parse('$baseUrl/authentication/token/validate_with_login?api_key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorMessage = json.decode(response.body)['status_message'];
      throw Exception('Failed to validate request token: $errorMessage');
    }
  }
  Future<String?> createSession(String requestToken) async {
    final body = json.encode({'request_token': requestToken});

    final response = await http.post(
      Uri.parse('$baseUrl/authentication/session/new?api_key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final sessionId = json.decode(response.body)['session_id'];
      return sessionId;
    } else {
      final errorMessage = json.decode(response.body)['status_message'];
      throw Exception('Failed to create session: $errorMessage');
    }
  }
  Future<int> getAccountId(String sessionId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/account?api_key=$apiKey&session_id=$sessionId'),
    );

    if (response.statusCode == 200) {
      final accountId = json.decode(response.body)['id'];
      return accountId;
    } else {
      final errorMessage = json.decode(response.body)['status_message'];
      throw Exception('Failed to get account details: $errorMessage');
    }

  }
  Future<Map<String, dynamic>> getAccountDetails(String sessionId) async {
    final response = await http.get(
      '$baseUrl/account?session_id=$sessionId&api_key=$apiKey' as Uri,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load account details');
    }
  }
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey&page=$page'),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<Movie> movies = (decodedResponse['results'] as List)
          .map((data) => Movie.fromJson(data))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to fetch now playing movies');
    }
}
  Future<List<dynamic>> getMovieWatchlist(String sessionId, String accountId) async {
    final response = await http.get(
      '$baseUrl/account/$accountId/watchlist/movies?session_id=$sessionId&api_key=$apiKey' as Uri,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load movie watchlist');
    }
  }

}
