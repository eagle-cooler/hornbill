import 'package:equatable/equatable.dart';
import 'package:eagle_org_layer/com/library.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

class LibraryInitial extends LibraryState {
  const LibraryInitial();
}

class LibraryLoading extends LibraryState {
  const LibraryLoading();
}

class LibraryLoaded extends LibraryState {
  final EagleLibrary library;
  final List<EagleEntry> entries;
  final EagleEntry? selectedEntry;

  const LibraryLoaded({
    required this.library,
    required this.entries,
    this.selectedEntry,
  });

  @override
  List<Object?> get props => [library, entries, selectedEntry];

  LibraryLoaded copyWith({
    EagleLibrary? library,
    List<EagleEntry>? entries,
    EagleEntry? selectedEntry,
    bool clearSelection = false,
  }) {
    return LibraryLoaded(
      library: library ?? this.library,
      entries: entries ?? this.entries,
      selectedEntry: clearSelection
          ? null
          : (selectedEntry ?? this.selectedEntry),
    );
  }
}

class LibraryError extends LibraryState {
  final String message;

  const LibraryError(this.message);

  @override
  List<Object?> get props => [message];
}
