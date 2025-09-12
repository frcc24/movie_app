import 'package:flutter/material.dart';
import 'package:movies__series_app/presentation/home_page.dart';
import '../core/model/filter_data.dart';

import '../core/model/medium.dart';
import '../presentation/genre_filter_screen/genre_filter_screen.dart';
import '../presentation/content_detail_screen/content_detail_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String genreFilter = '/genre-filter-screen';
  static const String contentDetail = '/content-detail-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomePage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case genreFilter:
        return MaterialPageRoute<FilterData?>(
          builder: (context) => GenreFilterScreen(),
        );
      case contentDetail:
        final medium = settings.arguments as Medium;
        return MaterialPageRoute(
          builder: (context) => ContentDetailScreen(medium: medium),
        );
      default:
        return null;
    }
  }
}
