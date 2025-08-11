import 'package:equatable/equatable.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class LoadLibrary extends LibraryEvent {
  final String libraryPath;

  const LoadLibrary(this.libraryPath);

  @override
  List<Object?> get props => [libraryPath];
}

class SearchEntries extends LibraryEvent {
  final String? name;
  final List<String>? tags;
  final List<String>? folders;

  const SearchEntries({this.name, this.tags, this.folders});

  @override
  List<Object?> get props => [name, tags, folders];
}

class SelectEntry extends LibraryEvent {
  final String entryId;

  const SelectEntry(this.entryId);

  @override
  List<Object?> get props => [entryId];
}

class ClearSelection extends LibraryEvent {
  const ClearSelection();
}
