import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/idea_local_datasource.dart';
import '../../data/models/idea_model.dart';
import '../../data/repositories/idea_repository_impl.dart';
import '../../domain/entities/idea.dart';
import '../../domain/repositories/idea_repository.dart';

// Repository Provider
final ideaRepositoryProvider = Provider<IdeaRepository>((ref) {
  final box = Hive.box<IdeaModel>('ideas');
  final dataSource = IdeaLocalDataSourceImpl(box);
  return IdeaRepositoryImpl(dataSource);
});

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filter Favorit Provider
final showOnlyFavoritesProvider = StateProvider<bool>((ref) => false);

// Idea List Notifier
class IdeaNotifier extends StateNotifier<AsyncValue<List<Idea>>> {
  final IdeaRepository _repository;

  IdeaNotifier(this._repository) : super(const AsyncValue.loading()) {
    getIdeas();
  }

  Future<void> getIdeas() async {
    state = const AsyncValue.loading();
    try {
      final ideas = await _repository.getIdeas();
      // Sort by newest
      ideas.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      state = AsyncValue.data(ideas);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addIdea(Idea idea) async {
    try {
      await _repository.saveIdea(idea);
      await getIdeas();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateIdea(Idea idea) async {
    try {
      await _repository.updateIdea(idea);
      await getIdeas();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteIdea(String id) async {
    try {
      await _repository.deleteIdea(id);
      await getIdeas();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleFavorite(Idea idea) async {
    final updatedIdea = idea.copyWith(isFavorite: !idea.isFavorite);
    await updateIdea(updatedIdea);
  }
}

final ideaListProvider = StateNotifierProvider<IdeaNotifier, AsyncValue<List<Idea>>>((ref) {
  final repository = ref.watch(ideaRepositoryProvider);
  return IdeaNotifier(repository);
});

// Filtered List Provider
final filteredIdeaListProvider = Provider<AsyncValue<List<Idea>>>((ref) {
  final ideasAsync = ref.watch(ideaListProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final showOnlyFavorites = ref.watch(showOnlyFavoritesProvider);

  return ideasAsync.whenData((ideas) {
    return ideas.where((idea) {
      final matchesQuery = idea.title.toLowerCase().contains(query) ||
          idea.description.toLowerCase().contains(query) ||
          idea.tags.any((tag) => tag.toLowerCase().contains(query));
      
      if (showOnlyFavorites) {
        return matchesQuery && idea.isFavorite;
      }
      return matchesQuery;
    }).toList();
  });
});
