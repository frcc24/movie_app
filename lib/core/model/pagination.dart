class Pagination {
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;
  final int totalItems;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.itemsPerPage,
    required this.totalItems,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      itemsPerPage: json['itemsPerPage'],
      totalItems: json['totalItems'],
    );
  }
}
