class Idea {
  final String id;
  final String title;
  final String description;
  final String? reference;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    this.reference,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  Idea copyWith({
    String? id,
    String? title,
    String? description,
    String? reference,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) {
    return Idea(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      reference: reference ?? this.reference,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
