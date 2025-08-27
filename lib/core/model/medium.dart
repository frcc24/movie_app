import '../enums/media_type.dart';
// import 'streaming_platform.dart';

class Medium {
  final int id;
  final MediaType type;
  final String title;
  final List<String> genres;
  final String synopsis;
  final double rating;
  // final List<StreamingPlatform> streamingPlatform;
  final String? poster;
  final int year;
  final String duration;
  final String? episodes;
  final String? seasons;

  Medium({
    required this.id,
    required this.type,
    required this.title,
    required this.genres,
    required this.synopsis,
    required this.rating,
    // required this.streamingPlatform,
    this.poster,
    required this.year,
    required this.duration,
    this.episodes,
    this.seasons,
  });

  factory Medium.fromJson(Map<String, dynamic> json) {
    return Medium(
      id: json['id'],
      type: MediaType.values.firstWhere(
        (type) => type.name.toLowerCase() == json['type'].toString().toLowerCase(),
        orElse: () => MediaType.movie,
      ),
      title: json['title'],
      genres: List<String>.from(json['genres']),
      synopsis: json['synopsis'],
      rating: (json['rating'] as num).toDouble(),
      // streamingPlatform: (json['streamingPlatform'] as List)
      //     .map(
      //       (platform) => StreamingPlatform.fromJson(platform),
      //     )
      //     .toList(),
      poster: json['poster'],
      year: json['year'],
      duration: json['duration'],
      episodes: json['episodes'],
      seasons: json['seasons'],
    );
  }
}
