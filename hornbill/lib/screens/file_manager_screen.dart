import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:eagle_org_layer/com/library.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/entry_list.dart';
import '../widgets/metadata_panel.dart';

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryBloc(),
      child: const FileManagerView(),
    );
  }
}

class FileManagerView extends StatefulWidget {
  const FileManagerView({super.key});

  @override
  State<FileManagerView> createState() => _FileManagerViewState();
}

class _FileManagerViewState extends State<FileManagerView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectLibraryFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null && mounted) {
      // Check if it's a valid Eagle library using similar logic to main.dart
      final validationCode = EagleLibrary.isEagleLibrary(selectedDirectory);

      if (validationCode == 1) {
        context.read<LibraryBloc>().add(LoadLibrary(selectedDirectory));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid Eagle Library (code: $validationCode)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<LibraryBloc>().add(SearchEntries(name: query));
    } else {
      // Clear search - show all entries
      context.read<LibraryBloc>().add(const SearchEntries());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hornbill'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: _selectLibraryFolder,
            tooltip: 'Select Library Folder',
          ),
        ],
      ),
      body: BlocBuilder<LibraryBloc, LibraryState>(
        builder: (context, state) {
          if (state is LibraryInitial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Select an Eagle Library to get started',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          if (state is LibraryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LibraryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _selectLibraryFolder,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (state is LibraryLoaded) {
            return Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search files...',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => _performSearch(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _performSearch,
                        child: const Text('Search'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<LibraryBloc>().add(
                            const SearchEntries(),
                          );
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                // Library info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  color: Colors.grey[100],
                  child: Text(
                    'Library: ${state.library.path} (${state.entries.length} entries)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // Main content
                Expanded(
                  child: Row(
                    children: [
                      // File list
                      Expanded(
                        flex: 2,
                        child: EntryList(entries: state.entries),
                      ),
                      // Metadata panel
                      Expanded(
                        flex: 1,
                        child: MetadataPanel(
                          selectedEntry: state.selectedEntry,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
