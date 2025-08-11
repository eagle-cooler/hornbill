# Tech Context - Hornbill App

## Technology Stack

### Flutter Framework
- **Version**: 3.8.1+
- **Language**: Dart
- **Platform Support**: Windows, macOS, Linux, Android, iOS, Web
- **UI Framework**: Material Design 3

### State Management
- **Primary**: flutter_bloc ^8.1.3
- **Pattern**: BLoC (Business Logic Component)
- **Streams**: Reactive programming with Stream/StreamBuilder

### Dependencies

#### Core Flutter Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  file_picker: ^6.1.1
  eagle_org_layer:
    path: ../eagle_org_layer
```

#### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

### Eagle Library Integration
- **Package**: eagle_org_layer (local path dependency)
- **Models**: EagleLibrary, EagleEntry, EagleFolder, etc.
- **Operations**: Library loading, entry searching, metadata access

## Development Environment

### IDE Setup
- **Primary IDE**: Visual Studio Code / Android Studio
- **Extensions**: Flutter, Dart, Bloc/Cubit snippets
- **Debugging**: Flutter DevTools integration

### Build System
- **Build Runner**: Flutter's standard build system
- **Platforms**: Native compilation for each target platform
- **Hot Reload**: Development productivity features

### File Structure
```
hornbill/
├── lib/
│   ├── main.dart              # App entry point
│   ├── bloc/                  # State management
│   │   ├── library_bloc.dart
│   │   ├── library_event.dart
│   │   └── library_state.dart
│   ├── screens/               # Main screens
│   │   └── file_manager_screen.dart
│   └── widgets/               # Reusable components
│       ├── entry_list.dart
│       └── metadata_panel.dart
├── pubspec.yaml              # Dependencies
├── analysis_options.yaml    # Linting rules
└── memory-bank/             # Documentation
```

## Technical Constraints

### Performance Requirements
- **Startup Time**: < 3 seconds on desktop
- **Library Loading**: Handle 1000+ entries efficiently
- **Memory Usage**: Reasonable memory footprint for large libraries
- **Search Response**: < 500ms for typical queries

### Platform Considerations
- **Windows**: Primary development and testing platform
- **File Access**: Cross-platform file system handling
- **UI Scaling**: Adaptive layouts for different screen sizes
- **Input Methods**: Mouse, touch, and keyboard support

### Compatibility
- **Flutter Version**: Minimum Flutter 3.8.1
- **Dart Version**: SDK compatibility with Flutter version
- **Eagle Format**: Compatible with existing Eagle library structure

## Architecture Decisions

### State Management Choice
**Decision**: Use flutter_bloc over alternatives (Provider, Riverpod, GetX)
**Rationale**:
- Mature and well-documented library
- Excellent debugging and testing support
- Clear separation of business logic and UI
- Stream-based reactive programming fits well with Flutter

### Local Package Integration
**Decision**: Use path dependency for eagle_org_layer
**Rationale**:
- Direct access to source code for debugging
- Synchronized development between library and app
- No need for package publishing during development

### Material Design 3
**Decision**: Use Material 3 over custom design system
**Rationale**:
- Comprehensive component library
- Built-in accessibility support
- Cross-platform consistency
- Reduced development time

## Development Patterns

### Code Organization
```dart
// Feature-based organization
lib/
  bloc/          # State management
  screens/       # Top-level screens
  widgets/       # Reusable UI components
  models/        # Data models (if needed beyond eagle_org_layer)
  utils/         # Helper functions
```

### State Management Pattern
```dart
// Event-driven architecture
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryInitial()) {
    on<LoadLibrary>(_onLoadLibrary);
    on<SearchEntries>(_onSearchEntries);
    on<SelectEntry>(_onSelectEntry);
  }
}
```

### Widget Composition
```dart
// Small, focused widgets
class FileManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LibraryBloc(),
      child: _FileManagerView(),
    );
  }
}
```

## Testing Strategy

### Unit Testing
- **BLoC Testing**: Test business logic in isolation
- **Widget Testing**: Test individual components
- **Integration Testing**: Test complete workflows

### Test Structure
```dart
// BLoC testing pattern
group('LibraryBloc', () {
  late LibraryBloc libraryBloc;
  
  setUp(() {
    libraryBloc = LibraryBloc();
  });
  
  blocTest<LibraryBloc, LibraryState>(
    'emits LibraryLoaded when LoadLibrary succeeds',
    build: () => libraryBloc,
    act: (bloc) => bloc.add(LoadLibrary(path)),
    expect: () => [LibraryLoading(), LibraryLoaded(entries)],
  );
});
```

## Build and Deployment

### Development Build
```bash
flutter run -d windows          # Windows desktop
flutter run -d chrome           # Web development
flutter run                     # Default platform
```

### Production Build
```bash
flutter build windows           # Windows executable
flutter build web               # Web deployment
flutter build apk               # Android APK
```

### Debug Configuration
- **Debug Mode**: Hot reload enabled, debug assertions active
- **Profile Mode**: Performance profiling with some debug info
- **Release Mode**: Optimized production build

## Tool Usage Patterns

### Flutter DevTools
- **Widget Inspector**: UI debugging and layout analysis
- **Performance Tab**: CPU and memory profiling
- **Timeline View**: Frame rendering analysis
- **Logging**: Debug output and error tracking

### IDE Integration
- **Code Completion**: Dart/Flutter-aware suggestions
- **Refactoring**: Safe code transformations
- **Debugging**: Breakpoints and step-through debugging
- **Hot Reload**: Instant code changes during development

## Integration Points

### eagle_org_layer Package
```dart
// Library operations
final library = EagleLibrary(path);
await library.load();
final entries = library.getAllEntries();
final searchResults = library.search(name, tags, folders);
```

### File System Access
```dart
// Directory selection
final result = await FilePicker.platform.getDirectoryPath();
if (result != null) {
  // Process selected directory
}
```

### State Synchronization
```dart
// BLoC event emission
context.read<LibraryBloc>().add(LoadLibrary(path));

// State consumption
BlocBuilder<LibraryBloc, LibraryState>(
  builder: (context, state) {
    // React to state changes
  }
)
```

## Performance Optimization

### Memory Management
- Lazy loading of entry metadata
- Image caching for thumbnails
- Dispose of unused resources

### UI Performance
- Use ListView.builder for large lists
- Implement scroll optimization
- Minimize widget rebuilds with targeted BlocBuilder usage

### Async Operations
- Background loading for better UX
- Debounced search to reduce API calls
- Proper error handling and recovery
