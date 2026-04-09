import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme.dart';
import '../../domain/entities/idea.dart';
import '../providers/idea_provider.dart';
import 'add_edit_screen.dart';

class DetailScreen extends ConsumerWidget {
  final String ideaId;

  const DetailScreen({super.key, required this.ideaId});

  void _deleteIdea(BuildContext context, WidgetRef ref, Idea idea) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        title: const Text('Hapus Ide?'),
        content: Text('Apakah Anda yakin ingin menghapus ide "${idea.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BATAL', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              ref.read(ideaListProvider.notifier).deleteIdea(idea.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close detail screen
            },
            child: const Text('HAPUS', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsync = ref.watch(ideaListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Ide'),
        actions: [
           ideasAsync.when(
            data: (ideas) {
              final idea = ideas.firstWhere((i) => i.id == ideaId);
              return IconButton(
                icon: Icon(
                  idea.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: idea.isFavorite ? AppTheme.primaryNeonPurple : null,
                ),
                onPressed: () => ref.read(ideaListProvider.notifier).toggleFavorite(idea),
              );
            },
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),
      body: ideasAsync.when(
        data: (ideas) {
          final idea = ideas.firstWhere(
            (i) => i.id == ideaId,
            orElse: () => throw Exception('Ide tidak ditemukan'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  idea.title,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppTheme.mutedTextColor),
                    const SizedBox(width: 4),
                    Text(
                      'Dibuat pada ${DateFormat('dd MMMM yyyy, HH:mm').format(idea.createdAt)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Text(
                    idea.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ),
                const SizedBox(height: 24),
                if (idea.reference != null && idea.reference!.isNotEmpty) ...[
                  const Text('Referensi:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryNeonBlue)),
                  const SizedBox(height: 8),
                  ...idea.reference!.split('\n').where((r) => r.trim().isNotEmpty).map((refText) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.link, size: 16, color: AppTheme.accentCyan),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              child: Text(
                                refText,
                                style: const TextStyle(color: AppTheme.accentCyan, decoration: TextDecoration.underline),
                              ),
                              onTap: () async {
                                final urlText = refText.trim();
                                if (urlText.isEmpty) return;
                                
                                String parsedUrl = urlText;
                                if (!parsedUrl.startsWith('http://') && !parsedUrl.startsWith('https://')) {
                                  parsedUrl = 'https://$parsedUrl';
                                }
                                
                                final uri = Uri.parse(parsedUrl);
                                try {
                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Bukan link yang valid atau tidak dapat dibuka: $refText')),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
                if (idea.tags.isNotEmpty) ...[
                  const Text('Tag:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.mutedTextColor)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: idea.tags.map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryNeonBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppTheme.primaryNeonBlue.withOpacity(0.3)),
                          ),
                          child: Text(
                            '#$tag',
                            style: const TextStyle(color: AppTheme.primaryNeonBlue, fontWeight: FontWeight.w600),
                          ),
                        )).toList(),
                  ),
                ],
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.edit, color: AppTheme.primaryNeonBlue),
                        label: const Text('EDIT', style: TextStyle(color: AppTheme.primaryNeonBlue)),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AddEditScreen(idea: idea)),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: AppTheme.primaryNeonBlue),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        label: const Text('HAPUS', style: TextStyle(color: Colors.redAccent)),
                        onPressed: () => _deleteIdea(context, ref, idea),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
