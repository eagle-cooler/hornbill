// TODO incomplete

class MetadataSmartFolderRule {
  String property;
  String method;
  final List<String> value;
  String $$hashKey;

  MetadataSmartFolderRule({
    required this.property,
    required this.method,
    required this.value,
    required this.$$hashKey,
  });

  factory MetadataSmartFolderRule.fromJson(Map<String, dynamic> json) {
    return MetadataSmartFolderRule(
      property: json['property'] ?? '',
      method: json['method'] ?? '',
      value: List<String>.from(json['value'] ?? []),
      $$hashKey: json['\$\$hashKey'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property': property,
      'method': method,
      'value': value,
      '\$\$hashKey': $$hashKey,
    };
  }
}

class MetadataSmartFolderCondition {
  final List<MetadataSmartFolderRule> rules;
  String match;
  String boolean;
  String $$hashKey;

  MetadataSmartFolderCondition({
    required this.rules,
    required this.match,
    required this.boolean,
    required this.$$hashKey,
  });

  factory MetadataSmartFolderCondition.fromJson(Map<String, dynamic> json) {
    return MetadataSmartFolderCondition(
      rules: (json['rules'] as List<dynamic>?)
              ?.map((rule) => MetadataSmartFolderRule.fromJson(rule))
              .toList() ??
          [],
      match: json['match'] ?? '',
      boolean: json['boolean'] ?? '',
      $$hashKey: json['\$\$hashKey'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rules': rules.map((rule) => rule.toJson()).toList(),
      'match': match,
      'boolean': boolean,
      '\$\$hashKey': $$hashKey,
    };
  }
}
