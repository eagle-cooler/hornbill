part of 'library.dart';

class EagleEntry extends EagleBaseObject {
  final EntryMetadata _metadata;
  final EagleLibrary _ref;

  // Expose metadata as getter
  EntryMetadata get metadata => _metadata;
  EagleLibrary get library => _ref;

  static bool exists(EagleLibrary lib, String id) {
    // Check if .info directory exists and contains metadata.json
    final infoDir = Directory("${lib.path}/images/$id.info");
    if (infoDir.existsSync()) {
      final metadataFile = File("${lib.path}/images/$id.info/metadata.json");
      return metadataFile.existsSync();
    }
    return false;
  }

  EagleEntry._internal(this._metadata, this._ref);

  factory EagleEntry.fromId(String id, EagleLibrary lib) {
    if (lib._entryCache.containsKey(id)) {
      return lib._entryCache[id]!;
    }

    if (EagleEntry.exists(lib, id)) {
      final entry = EagleEntry._internal(
        EntryMetadata.fromJson(
          jsonDecode(
            File(
              "${lib.path}/images/$id.info/metadata.json",
            ).readAsStringSync(),
          ),
        ),
        lib,
      );
      lib._entryCache[id] = entry;
      return entry;
    }

    throw Exception('Entry with id $id not found in library.');
  }

  @override
  void modify(Function func) {
    // Apply the modification function to the metadata
    func(_metadata);

    // Save the changes back to the file
    final file = File("${_ref.path}/images/${_metadata.id}.info/metadata.json");
    file.writeAsStringSync(jsonEncode(_metadata.toJson()));
  }
}
