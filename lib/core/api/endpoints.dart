abstract class Endpoints {
  static const String _baseUrl = 'http://10.20.30.16:8080';

  static String media() => '$_baseUrl/api/media';

  static String cast({required int id}) => '$_baseUrl/api/media/$id/cast';

  static String ratings({required int id}) => '$_baseUrl/api/media/$id/ratings';
}
