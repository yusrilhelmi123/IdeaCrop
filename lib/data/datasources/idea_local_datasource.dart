import 'package:hive/hive.dart';
import '../models/idea_model.dart';

abstract class IdeaLocalDataSource {
  Future<List<IdeaModel>> getIdeas();
  Future<void> saveIdea(IdeaModel idea);
  Future<void> deleteIdea(String id);
  Future<void> updateIdea(IdeaModel idea);
}

class IdeaLocalDataSourceImpl implements IdeaLocalDataSource {
  final Box<IdeaModel> _box;

  IdeaLocalDataSourceImpl(this._box);

  @override
  Future<List<IdeaModel>> getIdeas() async {
    return _box.values.toList();
  }

  @override
  Future<void> saveIdea(IdeaModel idea) async {
    await _box.put(idea.id, idea);
  }

  @override
  Future<void> deleteIdea(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> updateIdea(IdeaModel idea) async {
    await _box.put(idea.id, idea);
  }
}
