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

  String get ptBrName {
    switch (this) {
      case MediaType.movie:
        return 'Filmes';
      case MediaType.series:
        return 'Séries';
    }
  }
}

MediaType? mediaTypeFromPTBRString(String type) {
  switch (type.toLowerCase()) {
    case 'filmes':
      return MediaType.movie;
    case 'séries':
      return MediaType.series;
    default:
      return null;
  }
}
