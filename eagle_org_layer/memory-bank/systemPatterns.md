# System Patterns - Eagle Organization Layer

## Architecture Overview

### Layered Architecture
```
┌─────────────────────────────────────┐
│           UI Layer                  │
│  (Flutter Widgets / Web Frontend)  │
├─────────────────────────────────────┤
│        Application Layer            │
│     (Business Logic / Use Cases)   │
├─────────────────────────────────────┤
│         Domain Layer                │
│    (Models / Core Abstractions)    │
├─────────────────────────────────────┤
│      Infrastructure Layer          │
│  (File System / Storage / I/O)     │
└─────────────────────────────────────┘
```

### Core Components

#### 1. Eagle Library Models (`lib/models/`)
- **base.dart**: Core data structures (Tags, SavedFilters, MTime, Metadata)
- **folders.dart**: Folder hierarchy and metadata structures
- **entry_metadata.dart**: Individual file/asset metadata
- **smart.dart**: Smart folder definitions and queries

#### 2. Library Management (`lib/com/`)
- **library.dart**: Main EagleLibrary class for loading/validating libraries
- **EagleLibrary.isEagleLibrary()**: Detection logic for valid Eagle libraries
- **EagleLibrary.fromPath()**: Factory method to load libraries from filesystem

#### 3. File System Integration
- JSON-based metadata storage matching Eagle format
- File structure validation and integrity checking
- Cross-platform path handling

## Key Technical Decisions

### 1. Eagle Format Compatibility
**Decision**: Maintain 100% compatibility with Eagle's JSON-based library format
**Rationale**: 
- Zero-friction migration for existing Eagle users
- Interoperability with Eagle.cool app
- Preserves user investment in existing libraries

**Implementation**:
- Direct JSON deserialization matching Eagle schema
- Validation of required files (tags.json, metadata.json, etc.)
- Preservation of all Eagle-specific metadata fields

### 2. Flutter/Dart Technology Stack
**Decision**: Use Flutter for cross-platform development
**Rationale**:
- Single codebase for mobile, desktop, and web
- Native performance on all platforms
- Strong file I/O capabilities
- Growing ecosystem and community

### 3. File-Based Storage
**Decision**: Maintain Eagle's file-based storage approach
**Rationale**:
- Direct compatibility with Eagle libraries
- Simple backup and synchronization
- No database dependencies
- User retains full control of data

## Design Patterns in Use

### 1. Factory Pattern
```dart
// EagleLibrary.fromPath() creates instances from filesystem
final library = EagleLibrary.fromPath('/path/to/library');
```

### 2. Data Transfer Objects (DTOs)
```dart
// Models act as DTOs for JSON serialization
class Tags {
  factory Tags.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}
```

### 3. Validation Pattern
```dart
// Library validation before loading
if (!EagleLibrary.isEagleLibrary(path)) {
  throw Exception('Invalid Eagle Library');
}
```

## Component Relationships

### Library Loading Flow
```
User Input (path) 
    ↓
EagleLibrary.isEagleLibrary()
    ↓
File Existence Validation
    ↓
EagleLibrary.fromPath()
    ↓
JSON Deserialization
    ↓
Model Instantiation
    ↓
Ready Library Object
```

### Model Dependencies
- **Metadata** depends on **MetadataFolder** (from folders.dart)
- **EagleLibrary** aggregates Tags, SavedFilters, MTime, Metadata
- All models implement fromJson/toJson for serialization

## Critical Implementation Paths

### 1. Library Detection
- Check for required JSON files (tags.json, metadata.json, mtime.json, save-filters.json)
- Validate images folder existence
- Ensure directory structure integrity

### 2. JSON Parsing Strategy
- Defensive parsing with null safety
- Default values for missing fields
- Error handling for malformed JSON

### 3. Cross-Platform Considerations
- Path separator handling (Windows vs Unix)
- File encoding compatibility
- Permission and access rights management

## Performance Considerations
- Lazy loading of large metadata structures
- Streaming JSON parsing for large libraries
- Caching of frequently accessed metadata
- Efficient folder tree traversal algorithms
