enum _StarRating { one, two, three, four, five }

class _RatingBreakdown {
  final _StarRating stars;
  final double percentage;

  _RatingBreakdown({
    required this.stars,
    required this.percentage,
  });

  factory _RatingBreakdown.fromJson(Map<String, dynamic> json) {
    return _RatingBreakdown(
      stars: _StarRating.values[json['stars'] - 1],
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}

class UserRatings {
  final double averageRating;
  final int totalReviews;
  final List<_RatingBreakdown> breakdown;

  UserRatings({
    required this.averageRating,
    required this.totalReviews,
    required this.breakdown,
  });

  factory UserRatings.fromJson(Map<String, dynamic> json) {
    var breakdownFromJson = json['breakdown'] as List;
    List<_RatingBreakdown> breakdownList = breakdownFromJson
        .map(
          (breakdown) => _RatingBreakdown.fromJson(
            breakdown,
          ),
        )
        .toList();

    return UserRatings(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalReviews'],
      breakdown: breakdownList,
    );
  }
}
