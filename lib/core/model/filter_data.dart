import '../enums/media_type.dart';

class FilterData {
  final MediaType? type;
  final List<String>? genre;
  final int? year;
  final double? rating;

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
    double? rating,
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

  @override
  String toString() {
    var string = '';
    if (type != null) string += 'type: ${type!.ptBrName}, ';
    if (genre != null) string += 'genre: $genre, ';
    if (year != null) string += 'year: $year, ';
    if (rating != null) string += 'rating >= $rating, ';
    if (string.endsWith(', ')) {
      string = string.substring(0, string.length - 2);
    }

    return string;
  }
}
