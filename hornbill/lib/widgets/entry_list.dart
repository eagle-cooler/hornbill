import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagle_org_layer/com/library.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';

class EntryList extends StatelessWidget {
  final List<EagleEntry> entries;

  const EntryList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('No entries found', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final metadata = entry.metadata;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(_getFileIcon(metadata.ext), color: Colors.grey[600]),
            ),
            title: Text(metadata.name, overflow: TextOverflow.ellipsis),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type: ${metadata.ext.toUpperCase()}'),
                if (metadata.tags.isNotEmpty)
                  Text(
                    'Tags: ${metadata.tags.take(3).join(', ')}${metadata.tags.length > 3 ? '...' : ''}',
                    style: TextStyle(color: Colors.blue[600], fontSize: 12),
                  ),
              ],
            ),
            trailing: Text(
              _formatFileSize(metadata.size),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              context.read<LibraryBloc>().add(SelectEntry(metadata.id));
            },
          ),
        );
      },
    );
  }

  IconData _getFileIcon(String extension) {
    final ext = extension.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return Icons.image;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
      case 'flv':
        return Icons.video_file;
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
        return Icons.audio_file;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'zip':
      case 'rar':
      case '7z':
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
}
