import 'package:flutter/material.dart';
import 'package:movies__series_app/core/model/movie.dart';
import '../presentation/content_browse_screen/content_browse_screen.dart';
import '../presentation/genre_filter_screen/genre_filter_screen.dart';
import '../presentation/content_detail_screen/content_detail_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String contentBrowse = '/content-browse-screen';
  static const String genreFilter = '/genre-filter-screen';
  static const String contentDetail = '/content-detail-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const ContentBrowseScreen(),
    contentBrowse: (context) => const ContentBrowseScreen(),
    genreFilter: (context) => const GenreFilterScreen(),
    contentDetail: (context) {
      final movie = ModalRoute.of(context)!.settings.arguments as Movie;
      return ContentDetailScreen(movie: movie);
    },
  };
}
