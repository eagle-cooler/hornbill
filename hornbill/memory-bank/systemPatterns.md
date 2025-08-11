# System Patterns - Hornbill App

## Architecture Overview

### Flutter App Architecture
```
┌─────────────────────────────────────┐
│              UI Layer               │
│    (Widgets / Screens / Views)     │
├─────────────────────────────────────┤
│          Presentation Layer         │
│       (BLoC / State Management)    │
├─────────────────────────────────────┤
│           Domain Layer              │
│     (Business Logic / Use Cases)   │
├─────────────────────────────────────┤
│            Data Layer               │
│    (eagle_org_layer integration)   │
└─────────────────────────────────────┘
```

### Core Components

#### 1. State Management (`lib/bloc/`)
- **LibraryBloc**: Central state management for library operations
- **LibraryEvent**: Events for library actions (load, search, select)
- **LibraryState**: State representations (initial, loading, loaded, error)

#### 2. UI Components (`lib/screens/` & `lib/widgets/`)
- **FileManagerScreen**: Main application screen with library management
- **EntryList**: Scrollable list of library entries with metadata
- **MetadataPanel**: Detailed information sidebar for selected entries

#### 3. Integration Layer
- **eagle_org_layer package**: Core library operations and data models
- **File picker integration**: Platform-specific directory selection
- **Cross-platform file handling**: Consistent behavior across platforms

## Key Technical Decisions

### 1. State Management with BLoC Pattern
**Decision**: Use flutter_bloc for state management
**Rationale**:
- Predictable state flow with clear event-driven architecture
- Excellent testability and debugging capabilities
- Separation of business logic from UI components
- Stream-based reactive programming model

**Implementation**:
```dart
// Event-driven state updates
context.read<LibraryBloc>().add(LoadLibrary(path));

// Reactive UI updates
BlocBuilder<LibraryBloc, LibraryState>(
  builder: (context, state) => /* UI */
)
```

### 2. Widget Composition Strategy
**Decision**: Small, focused widgets with single responsibilities
**Rationale**:
- Better performance through selective rebuilds
- Improved code reusability and maintainability
- Easier testing of individual components
- Clear separation of concerns

### 3. Material Design 3 Framework
**Decision**: Use Material Design 3 as primary UI framework
**Rationale**:
- Consistent cross-platform appearance
- Comprehensive component library
- Built-in accessibility support
- Modern design language with theming support

## Design Patterns in Use

### 1. BLoC Pattern
```dart
// Event handling
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  on<LoadLibrary>(_onLoadLibrary);
  on<SearchEntries>(_onSearchEntries);
}

// State immutability
LibraryLoaded copyWith({
  List<EagleEntry>? entries,
  EagleEntry? selectedEntry,
}) => LibraryLoaded(/* ... */);
```

### 2. Builder Pattern
```dart
// Conditional UI rendering
BlocBuilder<LibraryBloc, LibraryState>(
  builder: (context, state) {
    if (state is LibraryLoading) return CircularProgressIndicator();
    if (state is LibraryError) return ErrorWidget(state.message);
    // ... other states
  }
)
```

### 3. Provider Pattern
```dart
// Dependency injection
BlocProvider(
  create: (context) => LibraryBloc(),
  child: FileManagerView(),
)
```

## Component Relationships

### State Flow
```
User Action (tap, search)
    ↓
Widget Event Handler
    ↓
BLoC Event Emission
    ↓
Business Logic Processing
    ↓
eagle_org_layer Operations
    ↓
State Update
    ↓
UI Rebuild
```

### Data Flow
- **Library Selection**: FilePicker → Validation → BLoC → eagle_org_layer
- **Entry Display**: eagle_org_layer → BLoC → EntryList Widget
- **Search**: User Input → BLoC → Filtered Results → UI Update
- **Selection**: User Tap → BLoC → MetadataPanel Update

## Critical Implementation Paths

### 1. Library Loading Flow
- Directory selection via FilePicker
- Library validation using eagle_org_layer
- Entry iteration and metadata loading
- State updates and UI rendering
- Error handling and user feedback

### 2. Search Implementation
- Real-time text input handling
- Debounced search execution
- Results filtering and sorting
- UI updates with filtered content
- Clear/reset functionality

### 3. Entry Selection
- User interaction handling
- State synchronization
- Metadata panel updates
- Visual feedback for selection

## Performance Considerations

### 1. Virtual Scrolling
- Large libraries require efficient scrolling
- ListView.builder for on-demand widget creation
- Memory management for entry caching

### 2. State Optimization
- Immutable state objects to prevent unnecessary rebuilds
- Selective BlocBuilder usage for targeted updates
- Efficient copyWith implementations

### 3. Asset Loading
- Lazy loading of thumbnails and previews
- Image caching strategies
- Background loading for better UX

## UI/UX Patterns

### 1. Progressive Disclosure
- Initial library selection screen
- Gradual revelation of library contents
- Detailed metadata on selection

### 2. Immediate Feedback
- Loading indicators during operations
- Real-time search results
- Visual feedback for user actions

### 3. Error Recovery
- Clear error messages with actionable guidance
- Retry mechanisms for failed operations
- Graceful degradation for missing data

## Cross-Platform Considerations

### 1. File System Access
- Platform-specific file picker implementations
- Path handling differences (Windows vs Unix)
- Permission management across platforms

### 2. UI Adaptation
- Material Design adaptation for different platforms
- Native-feeling interactions and navigation
- Platform-specific optimizations

### 3. Performance Characteristics
- Desktop vs mobile memory constraints
- Different input methods (mouse, touch, keyboard)
- Platform-specific file access patterns
