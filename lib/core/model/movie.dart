class Movie {
  final int id;
  final String title;
  final List<String> genres;
  final String synopsis;
  final double rating;
  final List<String> streamingPlatform;
  final String? poster;
  final int year;
  final String duration;

  Movie({
    required this.id,
    required this.title,
    required this.genres,
    required this.synopsis,
    required this.rating,
    required this.streamingPlatform,
    this.poster,
    required this.year,
    required this.duration,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      genres: List<String>.from(json['genres']),
      synopsis: json['synopsis'],
      rating: (json['rating'] as num).toDouble(),
      streamingPlatform: List<String>.from(json['streamingPlatform']),
      poster: json['poster'],
      year: json['year'],
      duration: json['duration'],
    );
  }
}
