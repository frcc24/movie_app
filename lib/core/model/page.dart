import 'pagination.dart';

class Page<T> {
  final List<T> data;
  final Pagination pagination;

  Page({
    required this.data,
    required this.pagination,
  });

  factory Page.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    var dataList = (json['data'] as List)
        .map(
          (item) => fromJsonT(
            item as Map<String, dynamic>,
          ),
        )
        .toList();

    return Page(
      data: dataList,
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
