import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/Models/movie.dart';

class WatchlistService {
  final String baseUrl = 'https://api.themoviedb.org/3'; // Your base URL here

  Future<List<Movie>> getWatchlist() async {
    try {
      final String sessionId = '90afc37c4c0aff55785693bacbc8a6cd1b73ee0c'; // Add your session ID here
      final String accountId = '24717925'; // Add your account ID here
      final String url = '$baseUrl/account/$accountId/watchlist/movies?api_key=31521ab741626851b73c684539c33b5a&session_id=$sessionId';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);
      final List<Movie> watchlist = List<Movie>.from(data['results'].map((movie) => Movie.fromJson(movie)));
      return watchlist;
    } catch (e) {
      print('Error fetching watchlist: $e');
      throw Exception('Failed to fetch watchlist');
    }
  }

  Future<void> removeFromWatchlist(int movieId) async {
    try {
      final String sessionId = ''; // Add your session ID here
      final String url = '$baseUrl/account/{account_id}/watchlist?api_key=31521ab741626851b73c684539c33b5a&session_id=$sessionId';
      final Map<String, dynamic> requestBody = {
        'media_type': 'movie',
        'media_id': movieId,
        'watchlist': false,
      };
      final response = await http.post(Uri.parse(url), body: json.encode(requestBody), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        // Movie removed successfully
        print('Movie removed from watchlist successfully');
      } else {
        throw Exception('Failed to remove movie from watchlist');
      }
    } catch (e) {
      print('Error removing movie from watchlist: $e');
      throw Exception('Failed to remove movie from watchlist');
    }
  }
  Future<void> addToBookmark(Movie movie) async {
    try {
      // Prepare the request body with the movie data
      Map<String, dynamic> requestBody = {
        'id': movie.id,
        'title': movie.title,
        'overview': movie.overview,
        // Add more fields if needed
      };

      // Make a POST request to add the movie to the bookmark/watchlist
      final response = await http.post(
        Uri.parse('$baseUrl/add-to-bookmark'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Movie added successfully
        print('Movie added to bookmark successfully');
      } else {
        // Movie adding failed
        print('Failed to add movie to bookmark: ${response.body}');
        throw Exception('Failed to add movie to bookmark');
      }
    } catch (e) {
      print('Error adding movie to bookmark: $e');
      throw Exception('Failed to add movie to bookmark');
    }
  }
}
