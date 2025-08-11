import 'package:flutter/material.dart';
import 'package:eagle_org_layer/com/library.dart';

class MetadataPanel extends StatelessWidget {
  final EagleEntry? selectedEntry;

  const MetadataPanel({super.key, this.selectedEntry});

  @override
  Widget build(BuildContext context) {
    if (selectedEntry == null) {
      return Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey[300]!)),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Select an entry to view metadata',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final metadata = selectedEntry!.metadata;

    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey[300]!)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 8),
                const Text(
                  'Metadata',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),

            // File preview placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getFileIcon(metadata.ext),
                    size: 48,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    metadata.ext.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Basic info
            _buildInfoSection('Basic Information', [
              _buildInfoRow('ID', metadata.id),
              _buildInfoRow('Name', metadata.name),
              _buildInfoRow('Extension', metadata.ext),
              _buildInfoRow('Size', _formatFileSize(metadata.size)),
              _buildInfoRow('Created', _formatTimestamp(metadata.btime)),
              _buildInfoRow('Modified', _formatTimestamp(metadata.mtime)),
            ]),

            const SizedBox(height: 16),

            // Tags
            if (metadata.tags.isNotEmpty)
              _buildInfoSection('Tags', [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: metadata.tags
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: Colors.blue[100],
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
                ),
              ]),

            const SizedBox(height: 16),

            // Folders
            if (metadata.folders.isNotEmpty)
              _buildInfoSection('Folders', [
                ...metadata.folders.map(
                  (folder) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.folder,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(folder)),
                      ],
                    ),
                  ),
                ),
              ]),

            const SizedBox(height: 16),

            // Additional metadata
            _buildInfoSection('Additional Information', [
              _buildInfoRow('Deleted', metadata.isDeleted ? 'Yes' : 'No'),
              _buildInfoRow('No Preview', metadata.noPreview ? 'Yes' : 'No'),
              _buildInfoRow(
                'Modification Time',
                _formatTimestamp(metadata.modificationTime),
              ),
              _buildInfoRow(
                'Last Modified',
                _formatTimestamp(metadata.lastModified),
              ),
            ]),

            // Extras if any
            if (metadata.extras.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildInfoSection('Extra Properties', [
                ...metadata.extras.entries.map(
                  (entry) => _buildInfoRow(entry.key, entry.value.toString()),
                ),
              ]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
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

  String _formatTimestamp(int timestamp) {
    if (timestamp == 0) return 'N/A';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
