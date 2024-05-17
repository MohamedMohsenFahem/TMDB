import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb/Controllers/watchListController.dart';
import 'package:tmdb/Models/movie.dart';

class BookMarkScreen extends StatelessWidget {
  final WatchlistController _watchlistController =
  Get.put(WatchlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Obx(
            () => _watchlistController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _watchlistController.movies.length,
          itemBuilder: (context, index) {
            Movie movie = _watchlistController.movies[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: Color(0xFF85BADB),
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: ListTile(
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                    'https://image.tmdb.org/t/p/w200/${movie.posterPath}',
                    width: 60,
                  )
                      : const SizedBox(width: 50),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _watchlistController.removeFromWatchlist(movie.id);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
