import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../providers/idea_provider.dart';
import 'add_edit_screen.dart';
import 'detail_screen.dart';
import 'about_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ideasAsync = ref.watch(filteredIdeaListProvider);
    final isOnlyFavorites = ref.watch(showOnlyFavoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IdeaCrop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Clock and Date Dashboard Widget
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryNeonBlue.withOpacity(0.8), AppTheme.primaryNeonPurple.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryNeonBlue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: StreamBuilder<DateTime>(
              stream: _timeStream,
              builder: (context, snapshot) {
                final now = snapshot.data ?? DateTime.now();
                return Column(
                  children: [
                    Text(
                      DateFormat('HH:mm').format(now),
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy').format(now),
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
                    decoration: InputDecoration(
                      hintText: 'Cari ide atau tag...',
                      prefixIcon: const Icon(Icons.search, color: AppTheme.primaryNeonBlue),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(searchQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    isOnlyFavorites ? Icons.favorite : Icons.favorite_border,
                    color: isOnlyFavorites ? AppTheme.primaryNeonPurple : Colors.grey,
                  ),
                  onPressed: () => ref.read(showOnlyFavoritesProvider.notifier).state = !isOnlyFavorites,
                ),
              ],
            ),
          ),
          Expanded(
            child: ideasAsync.when(
              data: (ideas) {
                if (ideas.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb_outline, size: 80, color: Colors.white.withOpacity(0.1)),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada ide tersimpan',
                          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ketuk + untuk memanen ide!',
                          style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: ideas.length,
                  itemBuilder: (context, index) {
                    final idea = ideas[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailScreen(ideaId: idea.id)),
                      ),
                      onLongPress: () {
                        // Quick Delete
                        ref.read(ideaListProvider.notifier).deleteIdea(idea.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('"${idea.title}" dihapus')),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryNeonBlue.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(color: idea.isFavorite ? AppTheme.primaryNeonPurple : AppTheme.primaryNeonBlue.withOpacity(0.5), width: 2),
                            ),
                            child: Icon(
                              idea.isFavorite ? Icons.star : Icons.lightbulb,
                              color: idea.isFavorite ? AppTheme.primaryNeonPurple : AppTheme.primaryNeonBlue,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            idea.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryNeonBlue.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditScreen()),
          ),
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
