enum MediumType { movie, series }

extension MediumTypeExtension on MediumType {
  String get name {
    switch (this) {
      case MediumType.movie:
        return 'movies';
      case MediumType.series:
        return 'series';
    }
  }
}

abstract class Endpoints {
  static const String _baseUrl = 'http://10.20.30.9:3000';

  static String medium({required MediumType type}) {
    return '$_baseUrl/api/${type.name}';
  }

  static String cast({required MediumType type, required int id}) => '$_baseUrl/api/${type.name}/$id/cast';

  static String ratings({required MediumType type, required int id}) => '$_baseUrl/api/${type.name}/$id/ratings';
}
