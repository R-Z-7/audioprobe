class VersionModel {
  int? id;
  String? status;
  String? version;
  String? supportingVersion;
  String? supportNumber;
  DateTime? createdAt;
  DateTime? updatedAt;

  VersionModel({
    this.id,
    this.status,
    this.version,
    this.supportingVersion,
    this.supportNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        id: json["id"],
        status: json["status"],
        version: json["version"],
        supportingVersion: json["supportingVersion"],
        supportNumber: json["supportNumber"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "version": version,
        "supportingVersion": supportingVersion,
        "supportNumber": supportNumber,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
