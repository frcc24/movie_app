abstract class Endpoints {
  static const String _baseUrl = 'https://movie-api.bridge.ufsc.br';

  static String media() => '$_baseUrl/api/media';

  static String cast({required int id}) => '$_baseUrl/api/media/$id/cast';

  static String ratings({required int id}) => '$_baseUrl/api/media/$id/ratings';
}
