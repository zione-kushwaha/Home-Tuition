/// Certificate model for user profile
class Certificate {
  final String id;
  final String name;
  final String issuingOrganization;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String? credentialId;
  final String? credentialUrl;

  Certificate({
    required this.id,
    required this.name,
    required this.issuingOrganization,
    this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.credentialUrl,
  });

  /// Create Certificate from JSON
  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'] as String,
      name: json['name'] as String,
      issuingOrganization: json['issuingOrganization'] as String,
      issueDate: json['issueDate'] != null
          ? DateTime.parse(json['issueDate'] as String)
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      credentialId: json['credentialId'] as String?,
      credentialUrl: json['credentialUrl'] as String?,
    );
  }

  /// Convert Certificate to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'issuingOrganization': issuingOrganization,
      'issueDate': issueDate?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'credentialId': credentialId,
      'credentialUrl': credentialUrl,
    };
  }

  /// Create a copy with some fields changed
  Certificate copyWith({
    String? id,
    String? name,
    String? issuingOrganization,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? credentialId,
    String? credentialUrl,
  }) {
    return Certificate(
      id: id ?? this.id,
      name: name ?? this.name,
      issuingOrganization: issuingOrganization ?? this.issuingOrganization,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      credentialId: credentialId ?? this.credentialId,
      credentialUrl: credentialUrl ?? this.credentialUrl,
    );
  }
}
