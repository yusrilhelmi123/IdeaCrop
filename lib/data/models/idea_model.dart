import 'package:hive/hive.dart';
import '../../domain/entities/idea.dart';

part 'idea_model.g.dart';

@HiveType(typeId: 0)
class IdeaModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String? reference;

  @HiveField(4)
  final List<String> tags;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime updatedAt;

  @HiveField(7)
  final bool isFavorite;

  IdeaModel({
    required this.id,
    required this.title,
    required this.description,
    this.reference,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  // Convert to Entity
  Idea toEntity() {
    return Idea(
      id: id,
      title: title,
      description: description,
      reference: reference,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isFavorite: isFavorite,
    );
  }

  // From Entity
  factory IdeaModel.fromEntity(Idea idea) {
    return IdeaModel(
      id: idea.id,
      title: idea.title,
      description: idea.description,
      reference: idea.reference,
      tags: idea.tags,
      createdAt: idea.createdAt,
      updatedAt: idea.updatedAt,
      isFavorite: idea.isFavorite,
    );
  }
}
