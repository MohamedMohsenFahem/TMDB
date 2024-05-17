import 'package:get/get.dart';
import 'package:tmdb/Models/movie.dart';
import 'package:tmdb/Services/watchListService.dart';

class WatchlistController extends GetxController {
  final WatchlistService _watchlistService = WatchlistService();

  var isLoading = true.obs;
  var movies = <Movie>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWatchlist();
  }

  Future<void> fetchWatchlist() async {
    try {
      isLoading(true);
      final watchlist = await _watchlistService.getWatchlist();
      movies.assignAll(watchlist);
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeFromWatchlist(int movieId) async {
    try {
      await _watchlistService.removeFromWatchlist(movieId);
      movies.removeWhere((movie) => movie.id == movieId);
    } catch (e) {
      // Handle error
      print('Error removing movie from watchlist: $e');
    }
  }
}
