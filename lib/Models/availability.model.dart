class AvailabilityModel {
  String? response;
  int? totalCount;
  List<AvailabilityData>? data;
  int? totalPages;
  int? currentPage;

  AvailabilityModel({
    this.response,
    this.totalCount,
    this.data,
    this.totalPages,
    this.currentPage,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityModel(
        response: json["response"],
        totalCount: json["totalCount"],
        data: json["data"] == null
            ? []
            : List<AvailabilityData>.from(
                json["data"]!.map((x) => AvailabilityData.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "totalCount": totalCount,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class AvailabilityData {
  int? id;
  DateTime? date;
  int? slots;
  int? availableSlots;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  AvailabilityData({
    this.id,
    this.date,
    this.slots,
    this.availableSlots,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory AvailabilityData.fromJson(Map<String, dynamic> json) =>
      AvailabilityData(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        slots: json["slots"],
        availableSlots: json["availableSlots"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "slots": slots,
        "availableSlots": availableSlots,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };
}
