/// Skill model for user profile
class Skill {
  final String id;
  final String name;
  final int? proficiencyLevel; // 1-5 scale
  final bool isVerified;

  Skill({
    required this.id,
    required this.name,
    this.proficiencyLevel,
    this.isVerified = false,
  });

  /// Create Skill from JSON
  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as String,
      name: json['name'] as String,
      proficiencyLevel: json['proficiencyLevel'] as int?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  /// Convert Skill to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'proficiencyLevel': proficiencyLevel,
      'isVerified': isVerified,
    };
  }

  /// Create a copy with some fields changed
  Skill copyWith({
    String? id,
    String? name,
    int? proficiencyLevel,
    bool? isVerified,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      proficiencyLevel: proficiencyLevel ?? this.proficiencyLevel,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
