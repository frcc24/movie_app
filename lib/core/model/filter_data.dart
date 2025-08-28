import '../enums/media_type.dart';

class FilterData {
  final MediaType? type;
  final List<String>? genre;
  final int? year;
  final int? rating;

  const FilterData({
    this.type,
    this.genre,
    this.year,
    this.rating,
  });

  FilterData copyWith({
    MediaType? type,
    List<String>? genre,
    int? year,
    int? rating,
  }) {
    return FilterData(
      type: type ?? this.type,
      genre: genre ?? this.genre,
      year: year ?? this.year,
      rating: rating ?? this.rating,
    );
  }

  Map<String, String> toQueryParams() {
    final params = <String, String>{};

    if (type != null) {
      params['type'] = type!.name;
    }
    if (genre != null && genre!.isNotEmpty) {
      params['genre'] = genre!.join(',');
    }
    if (year != null) {
      params['year'] = year.toString();
    }
    if (rating != null) {
      params['rating'] = rating.toString();
    }

    return params;
  }
}
