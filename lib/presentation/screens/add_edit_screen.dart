import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme.dart';
import '../../domain/entities/idea.dart';
import '../providers/idea_provider.dart';

class AddEditScreen extends ConsumerStatefulWidget {
  final Idea? idea;

  const AddEditScreen({super.key, this.idea});

  @override
  ConsumerState<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends ConsumerState<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _refController;
  late TextEditingController _tagController;
  List<String> _tags = [];
  List<String> _references = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.idea?.title ?? '');
    _descController = TextEditingController(text: widget.idea?.description ?? '');
    _refController = TextEditingController();
    _tagController = TextEditingController();
    _tags = widget.idea?.tags != null ? List.from(widget.idea!.tags) : [];
    
    if (widget.idea?.reference != null && widget.idea!.reference!.isNotEmpty) {
      _references = widget.idea!.reference!.split('\n').where((r) => r.trim().isNotEmpty).toList();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _refController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag.trim().replaceAll(' ', '_'));
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _addRef(String ref) {
    if (ref.isNotEmpty && !_references.contains(ref)) {
      setState(() {
        _references.add(ref.trim());
        _refController.clear();
      });
    }
  }

  void _removeRef(String ref) {
    setState(() {
      _references.remove(ref);
    });
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final idea = Idea(
        id: widget.idea?.id ?? const Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        reference: _references.isEmpty ? null : _references.join('\n'),
        tags: _tags,
        createdAt: widget.idea?.createdAt ?? now,
        updatedAt: now,
        isFavorite: widget.idea?.isFavorite ?? false,
      );

      if (widget.idea == null) {
        await ref.read(ideaListProvider.notifier).addIdea(idea);
      } else {
        await ref.read(ideaListProvider.notifier).updateIdea(idea);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idea == null ? 'Ide Baru' : 'Edit Ide'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('SIMPAN', style: TextStyle(color: AppTheme.primaryNeonBlue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Ide',
                  hintText: 'Apa pemikiran hebatmu?',
                ),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                validator: (value) => value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Jelaskan lebih detail...',
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (value) => value == null || value.isEmpty ? 'Deskripsi tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              const Text('Referensi (Opsional)', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.mutedTextColor)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _refController,
                      decoration: const InputDecoration(
                        hintText: 'Link URL atau buku...',
                        prefixIcon: Icon(Icons.link, size: 20),
                      ),
                      onFieldSubmitted: _addRef,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppTheme.primaryNeonPurple, size: 30),
                    onPressed: () => _addRef(_refController.text),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _references.map((ref) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryNeonPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.primaryNeonPurple.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.link, size: 16, color: AppTheme.primaryNeonPurple),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          ref,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () => _removeRef(ref),
                        child: const Icon(Icons.close, size: 18, color: Colors.redAccent),
                      ),
                    ],
                  ),
                )).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Tag', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.mutedTextColor)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        hintText: 'Tambahkan tag...',
                      ),
                      onFieldSubmitted: _addTag,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppTheme.primaryNeonBlue, size: 30),
                    onPressed: () => _addTag(_tagController.text),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: _tags.map((tag) => Chip(
                  label: Text(tag),
                  backgroundColor: AppTheme.primaryNeonBlue.withOpacity(0.1),
                  side: const BorderSide(color: AppTheme.primaryNeonBlue),
                  onDeleted: () => _removeTag(tag),
                  deleteIconColor: Colors.redAccent,
                  labelStyle: const TextStyle(color: AppTheme.primaryNeonBlue),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
