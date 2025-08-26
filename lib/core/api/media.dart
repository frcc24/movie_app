import 'package:dio/dio.dart';

import 'endpoints.dart';
import '../enums/media_type.dart';
import '../model/actor.dart';
import '../model/medium.dart';

Future<List<Medium>> getMedia({
  MediaType? type,
  String? genre,
  int? year,
  int? rating,
}) async {
  final response = await Dio().get(
    Endpoints.medium(),
    queryParameters: {
      if (type != null) 'type': type.name,
      if (genre != null) 'genre': genre,
      if (year != null) 'year': year,
      if (rating != null) 'rating': rating,
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = response.data;
    return jsonResponse.map((movie) => Medium.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<List<Actor>> getMediumCast(int id) async {
  final response = await Dio().get(Endpoints.cast(id: id));

  if (response.statusCode == 200) {
    List jsonResponse = response.data;

    return jsonResponse.map((actor) => Actor.fromJson(actor)).toList();
  } else {
    throw Exception('Failed to load movie cast');
  }
}

Future<Map<String, dynamic>> getMediumRatings(int id) async {
  final response = await Dio().get(Endpoints.ratings(id: id));

  if (response.statusCode == 200) {
    return response.data;
  } else {
    throw Exception('Failed to load movie ratings');
  }
}
