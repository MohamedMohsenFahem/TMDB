// lib/controllers/now_playing_controller.dart

import 'package:get/get.dart';
import 'package:tmdb/Models/movie.dart';
import 'package:tmdb/Services/tmdb_service.dart';

class NowPlayingController extends GetxController {
  final TMDBService _tmdbService = TMDBService();

  final movies = <Movie>[].obs;
  final isLoading = false.obs;
  final currentPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies();
  }

  Future<void> fetchNowPlayingMovies() async {
    try {
      isLoading.value = true;
      final List<Movie> fetchedMovies = await _tmdbService.getNowPlayingMovies(
        page: currentPage.value,
      );
      movies.addAll(fetchedMovies);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreMovies() async {
    currentPage.value++;
    await fetchNowPlayingMovies();
  }
}
