abstract class MetadataBaseFolder {
  final String id;
  String name;
  String description;
  int modificationTime;

  MetadataBaseFolder({
    required this.id,
    required this.name,
    this.description = '',
    required this.modificationTime,
  });

  MetadataBaseFolder copy();

}

class MetadataFolder extends MetadataBaseFolder {
  final List<MetadataFolder> children;
  final List<dynamic> tags;
  String password;
  String passwordTips;

  MetadataFolder({
    required super.id,
    required super.name,
    super.description,
    required super.modificationTime,
    this.children = const [],
    this.tags = const [],
    this.password = '',
    this.passwordTips = '',
  });

  factory MetadataFolder.fromJson(Map<String, dynamic> json) {
    return MetadataFolder(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      children:
          (json['children'] as List<dynamic>?)
              ?.map((child) => MetadataFolder.fromJson(child))
              .toList() ??
          [],
      modificationTime: json['modificationTime'] ?? 0,
      tags: List<dynamic>.from(json['tags'] ?? []),
      password: json['password'] ?? '',
      passwordTips: json['passwordTips'] ?? '',
    );
  }



  @override
  MetadataFolder copy() {
    return MetadataFolder(
      id: id,
      name: name,
      description: description,
      modificationTime: modificationTime,
      children: children.map((child) => child.copy()).toList(),
      tags: List<dynamic>.from(tags),
      password: password,
      passwordTips: passwordTips,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'children': children.map((child) => child.toJson()).toList(),
      'modificationTime': modificationTime,
      'tags': tags,
      'password': password,
      'passwordTips': passwordTips,
    };
  }
}

