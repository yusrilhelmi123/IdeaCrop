import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../domain/entities/idea.dart';

class IdeaCard extends StatelessWidget {
  final Idea idea;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const IdeaCard({
    super.key,
    required this.idea,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.01),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      idea.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      idea.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: idea.isFavorite ? AppTheme.primaryNeonPurple : Colors.grey,
                    ),
                    onPressed: onFavoriteTap,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                idea.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              if (idea.tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: idea.tags.take(3).map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryNeonBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.primaryNeonBlue.withOpacity(0.3)),
                    ),
                    child: Text(
                      '#$tag',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.primaryNeonBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )).toList(),
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    DateFormat('dd MMM yyyy').format(idea.createdAt),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  if (idea.reference != null && idea.reference!.isNotEmpty)
                    const Icon(Icons.link, size: 14, color: AppTheme.accentCyan),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
