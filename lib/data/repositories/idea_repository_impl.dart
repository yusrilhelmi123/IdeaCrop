import '../../domain/entities/idea.dart';
import '../../domain/repositories/idea_repository.dart';
import '../datasources/idea_local_datasource.dart';
import '../models/idea_model.dart';

class IdeaRepositoryImpl implements IdeaRepository {
  final IdeaLocalDataSource localDataSource;

  IdeaRepositoryImpl(this.localDataSource);

  @override
  Future<List<Idea>> getIdeas() async {
    final models = await localDataSource.getIdeas();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveIdea(Idea idea) async {
    await localDataSource.saveIdea(IdeaModel.fromEntity(idea));
  }

  @override
  Future<void> deleteIdea(String id) async {
    await localDataSource.deleteIdea(id);
  }

  @override
  Future<void> updateIdea(Idea idea) async {
    await localDataSource.updateIdea(IdeaModel.fromEntity(idea));
  }
}
