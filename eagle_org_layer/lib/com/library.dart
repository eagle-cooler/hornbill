import 'dart:convert';
import 'dart:io';

import 'package:eagle_org_layer/models/base.dart'
    show Tags, SavedFilters, MTime, Metadata;
import 'package:eagle_org_layer/models/entry_metadata.dart';
import 'package:eagle_org_layer/com/base.dart';

part 'entry.dart';
part 'folder.dart';

class EagleLibrary {
  static final Map<String, EagleLibrary> _instances = {};
  // hash function by path
  @override
  int get hashCode => path.hashCode;

  @override
  bool operator ==(Object other) {
    // check if type
    if (other is! EagleLibrary) return false;

    // check if path is equal
    return path == other.path;
  }

  //
  final String path;
  final Tags tags;
  final SavedFilters savedFilters;
  final MTime mTime;
  final Metadata metadata;

  // internal instance based caching
  final Map<String, EagleEntry> _entryCache = {};

  List<EagleEntry> get openedEntries => _entryCache.values.toList();

  /// Get an entry by its ID
  EagleEntry? getEntry(String id) {
    try {
      final entry = EagleEntry.fromId(id, this);
      _entryCache[id] = entry;
      return entry;
    } catch (e) {
      return null;
    }
  }

  /// Iterate through all entries in the library
  Iterable<EagleEntry> iterEntries() sync* {
    final imagesDir = Directory('$path/images');

    if (!imagesDir.existsSync()) {
      return;
    }

    // Get all .info directories which contain entry metadata
    final entryDirs = imagesDir
        .listSync()
        .where((entity) => entity is Directory && entity.path.endsWith('.info'))
        .cast<Directory>();

    for (final dir in entryDirs) {
      try {
        // Use basename to get just the directory name
        final dirName = dir.path.split(Platform.pathSeparator).last;
        final entryId = dirName.replaceAll('.info', '');
        final entry = getEntry(entryId);

        if (entry != null) {
          yield entry;
        }
      } catch (e) {
        // Skip invalid entries
        continue;
      }
    }
  }

  /// Get all entries as a list
  List<EagleEntry> getAllEntries() {
    return iterEntries().toList();
  }

  /// Search entries by name, tags, and folders
  List<EagleEntry> search({
    String? name,
    List<String>? tags,
    List<String>? folders,
  }) {
    final results = <EagleEntry>[];

    for (final entry in iterEntries()) {
      bool matches = true;

      // Check name filter
      if (name != null && name.isNotEmpty) {
        matches =
            matches &&
            entry._metadata.name.toLowerCase().contains(name.toLowerCase());
      }

      // Check tags filter
      if (tags != null && tags.isNotEmpty) {
        matches =
            matches && tags.any((tag) => entry._metadata.tags.contains(tag));
      }

      // Check folders filter
      if (folders != null && folders.isNotEmpty) {
        matches =
            matches &&
            folders.any((folder) => entry._metadata.folders.contains(folder));
      }

      if (matches) {
        results.add(entry);
      }
    }

    return results;
  }

  EagleLibrary._internal({
    required this.path,
    required this.tags,
    required this.savedFilters,
    required this.mTime,
    required this.metadata,
  });

  static int isEagleLibrary(String path) {
    // check path exists
    if (!Directory(path).existsSync()) {
      return -1;
    }

    // if actions.json exists
    if (!File('$path/actions.json').existsSync()) {
      return -2;
    }

    // if metadata.json exists
    if (!File('$path/metadata.json').existsSync()) {
      return -3;
    }

    // if mtime.json exists
    if (!File('$path/mtime.json').existsSync()) {
      return -4;
    }

    // if saved-filters.json exists
    if (!File('$path/saved-filters.json').existsSync()) {
      return -5;
    }

    // if tags.json exists
    if (!File('$path/tags.json').existsSync()) {
      return -6;
    }

    // if images folder exists
    if (!Directory('$path/images').existsSync()) {
      return -7;
    }

    return 1;
  }

  factory EagleLibrary.fromPath(String path) {
    // make path absolute
    final absolutePath = Directory(path).absolute.path;

    if (_instances.containsKey(absolutePath)) {
      return _instances[absolutePath]!;
    }

    final x = isEagleLibrary(absolutePath);
    if (x != 1) {
      throw Exception('Invalid Eagle Library ($x)');
    }

    // create json loaded objects
    final tagsRaw = File('$absolutePath/tags.json').readAsStringSync();
    final savedFiltersRaw = File(
      '$absolutePath/saved-filters.json',
    ).readAsStringSync();
    final mTimeRaw = File('$absolutePath/mtime.json').readAsStringSync();
    final metadataRaw = File('$absolutePath/metadata.json').readAsStringSync();

    final tagsJson = jsonDecode(tagsRaw);
    final savedFiltersJson = jsonDecode(savedFiltersRaw);
    final mTimeJson = jsonDecode(mTimeRaw);
    final metadataJson = jsonDecode(metadataRaw);

    return EagleLibrary._internal(
      path: absolutePath,
      tags: Tags.fromJson(tagsJson),
      savedFilters: SavedFilters.fromJson(savedFiltersJson),
      mTime: MTime.fromJson(mTimeJson),
      metadata: Metadata.fromJson(metadataJson),
    );
  }
}
