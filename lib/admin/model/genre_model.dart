class GenreModel {
  final int id_genre;
  final String genre;

  GenreModel({
    required this.id_genre,
    required this.genre,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id_genre: json["id_genre"],
      genre: json["genre"],
    );
  }

  static List<GenreModel> fromJsonList(List list) {
    return list.map((item) => GenreModel.fromJson(item)).toList();
  }

  /// Prevent overriding toString
  String userAsString() {
    return '#$id_genre $genre';
  }

  /// Check equality of two models
  bool isEqual(GenreModel model) {
    return id_genre == model.id_genre;
  }

  @override
  String toString() => genre;
}
