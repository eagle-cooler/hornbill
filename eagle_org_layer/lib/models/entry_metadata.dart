class EntryMetadata {
  final String id;
  String name;
  int size;
  int btime;
  int mtime;
  String ext;
  final List<String> tags;
  final List<String> folders;
  bool isDeleted;
  int modificationTime;
  int lastModified;
  bool noPreview;

  //
  Map<String, dynamic> extras;

  EntryMetadata({
    required this.id,
    required this.name,
    required this.size,
    required this.btime,
    required this.mtime,
    required this.ext,
    required this.tags,
    required this.folders,
    required this.isDeleted,
    required this.modificationTime,
    required this.lastModified,
    required this.noPreview,
    required this.extras,
  });

  factory EntryMetadata.fromJson(Map<String, dynamic> json) {
    // copies
    Map<String, dynamic> jsonCopy = Map<String, dynamic>.from(json);

    var id = jsonCopy.remove("id") ?? '';
    var name = jsonCopy.remove("name") ?? '';
    var size = jsonCopy.remove("size") ?? 0;
    var btime = jsonCopy.remove("btime") ?? 0;
    var mtime = jsonCopy.remove("mtime") ?? 0;
    var ext = jsonCopy.remove("ext") ?? '';
    var tags = List<String>.from(jsonCopy.remove("tags") ?? []);
    var folders = List<String>.from(jsonCopy.remove("folders") ?? []);
    var isDeleted = jsonCopy.remove("isDeleted") ?? false;
    var modificationTime = jsonCopy.remove("modificationTime") ?? 0;
    var lastModified = jsonCopy.remove("lastModified") ?? 0;
    var noPreview = jsonCopy.remove("noPreview") ?? false;
    
    return EntryMetadata(
      id: id,
      name: name,
      size: size,
      btime: btime,
      mtime: mtime,
      ext: ext,
      tags: tags,
      folders: folders,
      isDeleted: isDeleted,
      modificationTime: modificationTime,
      lastModified: lastModified,
      noPreview: noPreview,
      extras: jsonCopy
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>.from(extras);
    data['id'] = id;
    data['name'] = name;
    data['size'] = size;
    data['btime'] = btime;
    data['mtime'] = mtime;
    data['ext'] = ext;
    data['tags'] = tags;
    data['folders'] = folders;
    data['isDeleted'] = isDeleted;
    data['modificationTime'] = modificationTime;
    data['lastModified'] = lastModified;
    data['noPreview'] = noPreview;
    return data;
  }

  EntryMetadata copy() {
    return EntryMetadata(
      id: id,
      name: name,
      size: size,
      btime: btime,
      mtime: mtime,
      ext: ext,
      tags: List<String>.from(tags),
      folders: List<String>.from(folders),
      isDeleted: isDeleted,
      modificationTime: modificationTime,
      lastModified: lastModified,
      noPreview: noPreview,
      extras: Map<String, dynamic>.from(extras),
    );
  }

}

