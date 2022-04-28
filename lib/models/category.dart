class Categories {
  final String id;
  final String categoryName;

  Categories({
    required this.id,
    required this.categoryName,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryName': categoryName,
      };

  static Categories fromJson(Map<String, dynamic> json) => Categories(
        id: json['id'],
        categoryName: json['categoryName'],
      );
}
