class PageResponse {
  final dynamic items;

  final bool hasPrevPage;
  final bool hasNextPage;

  final int totalPages;
  final int totalItems;

  PageResponse({this.items, this.hasPrevPage, this.hasNextPage, this.totalPages, this.totalItems});

  PageResponse withNewItems(dynamic items)
    => PageResponse(
      items: items,
      hasPrevPage: hasPrevPage,
      hasNextPage: hasNextPage,
      totalPages: totalPages,
      totalItems: totalItems,
    );

  factory PageResponse.fromJson(dynamic json)
    => PageResponse(
      items: json['items'],
      hasPrevPage: json['has_prev_page'],
      hasNextPage: json['has_next_page'],
      totalPages: json['total_pages'],
      totalItems: json['total_items'],
    );
}