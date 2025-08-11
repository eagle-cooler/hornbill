import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eagle_org_layer/com/library.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(const LibraryInitial()) {
    on<LoadLibrary>(_onLoadLibrary);
    on<SearchEntries>(_onSearchEntries);
    on<SelectEntry>(_onSelectEntry);
    on<ClearSelection>(_onClearSelection);
  }

  Future<void> _onLoadLibrary(
    LoadLibrary event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryLoading());

    try {
      final library = EagleLibrary.fromPath(event.libraryPath);
      final entries = library.getAllEntries(); // Get all entries initially
      emit(LibraryLoaded(library: library, entries: entries));
    } catch (e) {
      emit(LibraryError('Failed to load library: ${e.toString()}'));
    }
  }

  Future<void> _onSearchEntries(
    SearchEntries event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;

      try {
        final entries = currentState.library.search(
          name: event.name,
          tags: event.tags,
          folders: event.folders,
        );

        emit(currentState.copyWith(entries: entries, clearSelection: true));
      } catch (e) {
        emit(LibraryError('Search failed: ${e.toString()}'));
      }
    }
  }

  Future<void> _onSelectEntry(
    SelectEntry event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;

      try {
        final entry = currentState.library.getEntry(event.entryId);
        emit(currentState.copyWith(selectedEntry: entry));
      } catch (e) {
        emit(LibraryError('Failed to select entry: ${e.toString()}'));
      }
    }
  }

  Future<void> _onClearSelection(
    ClearSelection event,
    Emitter<LibraryState> emit,
  ) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      emit(currentState.copyWith(clearSelection: true));
    }
  }
}
