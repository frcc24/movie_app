enum MediaType { movie, series }

extension MediaTypeExtension on MediaType {
  String get name {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.series:
        return 'series';
    }
  }
}
