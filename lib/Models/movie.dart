
class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      posterUrl: json['posterUrl'] ?? '',
    );
  }



}
