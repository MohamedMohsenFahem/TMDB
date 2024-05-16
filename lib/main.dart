import 'package:flutter/material.dart';
import 'package:tmdb/Screens/now_playing.dart';

void main() {
  runApp(const TMDB());
}

class TMDB extends StatelessWidget {
  const TMDB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMDB Client',
      home: NowPlayingScreen(),
    );

  }
}
