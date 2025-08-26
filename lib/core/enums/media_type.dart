enum MediaType { movie, series }

extension MediaTypeExtension on MediaType {
  String get name {
    switch (this) {
      case MediaType.movie:
        return 'movies';
      case MediaType.series:
        return 'series';
    }
  }
}
