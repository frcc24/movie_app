import 'dart:convert';
import 'package:dio/dio.dart';

import '../model/actor.dart';
import '../model/user_ratings.dart';
import 'endpoints.dart';
import '../model/movie.dart';

Future<List<Movie>> getMovies({
  String? genre,
  int? year,
  int? rating,
}) async {
  final response = await Dio().get(
    Endpoints.medium(type: MediumType.movie),
    queryParameters: {
      if (genre != null) 'genre': genre,
      if (year != null) 'year': year,
      if (rating != null) 'rating': rating,
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = response.data;
    return jsonResponse.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

Future<List<Actor>> getMovieCast(int id) async {
  final response = await Dio().get(Endpoints.cast(type: MediumType.movie, id: id));

  if (response.statusCode == 200) {
    List jsonResponse = response.data;

    return jsonResponse.map((actor) => Actor.fromJson(actor)).toList();
  } else {
    throw Exception('Failed to load movie cast');
  }
}

Future<UserRatings> getMovieRatings(int id) async {
  final response = await Dio().get(Endpoints.ratings(type: MediumType.movie, id: id));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.data);
    return UserRatings.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load movie ratings');
  }
}
