# Eagle Organization Layer

A Flutter package that provides a universal file organization layer compatible with Eagle.cool libraries. This package enables you to read, write, and manage Eagle library formats across all platforms.

## Features

- **Eagle Format Compatibility**: Full support for Eagle.cool library structure
- **Cross-Platform**: Works on Windows, macOS, Linux, iOS, Android, and web
- **Library Management**: Load, validate, and manage Eagle libraries
- **Entry Handling**: Iterate through library entries with metadata access
- **Search & Filtering**: Find entries by name, tags, and folders
- **Flutter Integration**: Easy integration into Flutter applications

## Getting Started

### Prerequisites
- Flutter SDK (>=1.17.0)
- Dart SDK (>=3.8.1)

### Installation

Add to your `pubspec.yaml`:
```yaml
dependencies:
  eagle_org_layer:
    path: ../eagle_org_layer  # For local development
```

### Basic Usage

```dart
import 'package:eagle_org_layer/library.dart';

// Load an existing Eagle library
final library = EagleLibrary.fromPath('/path/to/eagle/library');

// Check if it's a valid Eagle library
if (library.isEagleLibrary()) {
  // Iterate through all entries
  for (final entry in library.iterEntries()) {
    print('Entry: ${entry.name}');
    print('Tags: ${entry.tags}');
  }
  
  // Search for specific entries
  final results = library.search('image', tags: ['design'], folders: ['inspiration']);
}
```

## What It Does

This package serves as the foundation for building applications that can:
- Replace or enhance Eagle.cool functionality
- Provide cross-platform access to Eagle libraries
- Enable custom file organization workflows
- Build collaborative asset management tools

## Development

```bash
# Get dependencies
flutter pub get

# Run tests
flutter test

# Test with a real Eagle library
dart run lib/main.dart /path/to/eagle/library
```

## License

This project is open source and available under the [LICENSE](LICENSE) file.
