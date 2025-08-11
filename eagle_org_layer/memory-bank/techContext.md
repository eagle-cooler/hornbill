# Technical Context - Eagle Organization Layer

## Technology Stack

### Core Technologies
- **Language**: Dart 3.8.1+
- **Framework**: Flutter (>=1.17.0)
- **Platform**: Cross-platform (Windows, macOS, Linux, iOS, Android, Web)
- **Package Manager**: pub (Dart's package manager)

### Dependencies
```yaml
# Core Dependencies
flutter: sdk: flutter

# Development Dependencies  
flutter_test: sdk: flutter
flutter_lints: ^5.0.0
```

### Project Structure
```
eagle_org_layer/
├── lib/
│   ├── main.dart              # Entry point for testing
│   ├── lib.dart               # Package exports
│   ├── models.dart            # Model exports
│   ├── com/
│   │   └── library.dart       # EagleLibrary core logic
│   └── models/
│       ├── base.dart          # Core data structures
│       ├── entry_metadata.dart # Asset metadata
│       ├── folders.dart       # Folder structures
│       └── smart.dart         # Smart folder logic
├── pubspec.yaml              # Package configuration
└── analysis_options.yaml    # Dart analyzer config
```

## Development Setup

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK 3.8.1+
- VS Code with Flutter/Dart extensions
- Git for version control

### Local Development
```bash
# Clone repository
git clone <repository-url>
cd eagle_org_layer

# Get dependencies
flutter pub get

# Run tests
flutter test

# Run main entry for testing
dart run lib/main.dart <path-to-eagle-library>
```

### Build Configuration
- **Package Type**: Flutter package (not app)
- **Target Platforms**: All Flutter-supported platforms
- **Deployment**: As a reusable package for integration into applications

## Technical Constraints

### Eagle Format Compatibility
- **JSON Schema**: Must match exact Eagle.cool metadata format
- **File Structure**: Strict adherence to Eagle directory layout
- **Metadata Fields**: Preserve all Eagle-specific fields and structures

### Performance Requirements
- **Large Libraries**: Handle libraries with 10k+ assets
- **Memory Efficiency**: Lazy loading for large datasets
- **Cross-Platform**: Consistent performance across all target platforms

### File System Constraints
- **Path Handling**: Cross-platform path compatibility
- **Encoding**: UTF-8 support for international file names
- **Permissions**: Read/write access to user directories

## Tool Usage Patterns

### VS Code Configuration
```json
// launch.json for debugging with arguments
{
    "name": "eagle_org_layer",
    "type": "dart", 
    "request": "launch",
    "program": "lib/main.dart",
    "args": ["C:\\path\\to\\eagle\\library"]
}
```

### Code Quality
- **Linting**: flutter_lints package for consistent code style
- **Analysis**: Dart analyzer with strict settings
- **Testing**: Unit tests for all core functionality

### Development Workflow
1. **Model-First Development**: Define data structures first
2. **Test-Driven Development**: Write tests before implementation
3. **Cross-Platform Testing**: Validate on multiple platforms
4. **Eagle Compatibility Testing**: Test with real Eagle libraries

## Integration Patterns

### As a Flutter Package
```dart
// Other Flutter apps can depend on this package
dependencies:
  eagle_org_layer:
    path: ../eagle_org_layer
```

### Usage in Applications
```dart
import 'package:eagle_org_layer/library.dart';

// Load Eagle library
final library = EagleLibrary.fromPath('/path/to/library');

// Access metadata
print('Library has ${library.metadata.folders.length} folders');
```

## Deployment Strategy

### Package Distribution
- **pub.dev**: Publish as public Dart package
- **GitHub**: Source code and releases
- **Documentation**: API docs generated from code comments

### Version Management
- **Semantic Versioning**: Major.Minor.Patch
- **Changelog**: Document all changes
- **Compatibility**: Maintain backward compatibility with Eagle format

## Security Considerations
- **File Access**: Validate paths to prevent directory traversal
- **JSON Parsing**: Secure parsing to prevent injection attacks
- **User Data**: Respect user privacy and data ownership
- **Cross-Platform**: Handle platform-specific security models
