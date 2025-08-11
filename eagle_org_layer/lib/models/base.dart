import 'package:eagle_org_layer/models/folders.dart';

class Tags {
  final List<String> historyTags;
  final List<String> starredTags;

  Tags({required this.historyTags, required this.starredTags});

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      historyTags: List<String>.from(json['historyTags'] ?? []),
      starredTags: List<String>.from(json['starredTags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'historyTags': historyTags, 'starredTags': starredTags};
  }

  Tags copy() {
    return Tags(
      historyTags: List<String>.from(historyTags),
      starredTags: List<String>.from(starredTags),
    );
  }
}

class SavedFilters {
  final List<dynamic> filters;

  SavedFilters({required this.filters});

  factory SavedFilters.fromJson(List<dynamic> json) {
    return SavedFilters(filters: List<dynamic>.from(json));
  }

  List<dynamic> toJson() {
    return filters;
  }

  SavedFilters copy() {
    return SavedFilters(
      filters: List<dynamic>.from(filters),
    );
  }
}

class MTime {
  final Map<String, int> timeMap;
  int all;

  MTime({required this.timeMap, required this.all});

  factory MTime.fromJson(Map<String, dynamic> json) {
    // copy json but pop all
    final all = json['all'] ?? 0;
    final timeMap = Map<String, int>.from(json);
    timeMap.remove('all');
    return MTime(timeMap: timeMap, all: all);
  }

  Map<String, dynamic> toJson() {
    return {...timeMap, "all": all};
  }

  MTime copy() {
    return MTime(
      timeMap: Map<String, int>.from(timeMap),
      all: all,
    );
  }
}

class Metadata {
  int modificationTime;
  String applicationVersion;
  final List<dynamic> tagsGroups;
  final List<dynamic> quickAccess;
  final List<dynamic> smartFolders;
  final List<MetadataFolder> folders;

  Metadata({
    required this.modificationTime,
    required this.applicationVersion,
    required this.tagsGroups,
    required this.quickAccess,
    required this.smartFolders,
    required this.folders,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      modificationTime: json['modificationTime'] ?? 0,
      applicationVersion: json['applicationVersion'] ?? '',
      tagsGroups: List<dynamic>.from(json['tagsGroups'] ?? []),
      quickAccess: List<dynamic>.from(json['quickAccess'] ?? []),
      smartFolders: List<dynamic>.from(json['smartFolders'] ?? []),
      folders: (json['folders'] as List<dynamic>?)
          ?.map((folder) => MetadataFolder.fromJson(folder))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modificationTime': modificationTime,
      'applicationVersion': applicationVersion,
      'tagsGroups': tagsGroups,
      'quickAccess': quickAccess,
      'smartFolders': smartFolders,
      'folders': folders.map((folder) => folder.toJson()).toList(),
    };
  }

  Metadata copy() {
    return Metadata(
      modificationTime: modificationTime,
      applicationVersion: applicationVersion,
      tagsGroups: List<dynamic>.from(tagsGroups),
      quickAccess: List<dynamic>.from(quickAccess),
      smartFolders: List<dynamic>.from(smartFolders),
      folders: folders.map((folder) => folder.copy()).toList(),
    );
  }
}
