import '../entities/idea.dart';

abstract class IdeaRepository {
  Future<List<Idea>> getIdeas();
  Future<void> saveIdea(Idea idea);
  Future<void> deleteIdea(String id);
  Future<void> updateIdea(Idea idea);
}
