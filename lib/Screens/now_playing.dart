// lib/screens/now_playing_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb/Controllers/now_playing.dart';
import 'package:tmdb/Models/movie.dart';
import 'package:tmdb/Screens/BookMark.dart';

class NowPlayingScreen extends StatelessWidget {
  final NowPlayingController _nowPlayingController =
      Get.put(NowPlayingController());

  NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: const Text('Now Playing Movies'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.bookmark_border),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>BookMarkScreen (),
                      ));
                },
              ),
            ],
          )
        ],
      ),
      body: Obx(
        () {
          if (_nowPlayingController.isLoading.value &&
              _nowPlayingController.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: _nowPlayingController.movies.length + 1,
              itemBuilder: (context, index) {
                if (index < _nowPlayingController.movies.length) {
                  final Movie movie = _nowPlayingController.movies[index];
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
                        subtitle: Text(movie.overview,maxLines: 6,),
                        trailing: IconButton(
                          icon: Icon(Icons.bookmark_border),
                          onPressed: () {
                          },
                        ),
                      ),
                    ),
                  );
                } else if (!_nowPlayingController.isLoading.value) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () => _nowPlayingController.loadMoreMovies(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Load More',style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
