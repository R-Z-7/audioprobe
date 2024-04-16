class BookingModel {
  String? response;
  int? totalCount;
  List<BookingData>? data;
  int? totalPages;
  int? currentPage;

  BookingModel({
    this.response,
    this.totalCount,
    this.data,
    this.totalPages,
    this.currentPage,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        response: json["response"],
        totalCount: json["totalCount"],
        data: json["data"] == null
            ? []
            : List<BookingData>.from(json["data"]!.map((x) => BookingData.fromJson(x))),
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

class BookingData {
  int? id;
  String? review;
  DateTime? bookingTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? clientId;

  BookingData({
    this.id,
    this.review,
    this.bookingTime,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.clientId,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        id: json["id"],
        review: json["review"],
        bookingTime: json["bookingTime"] == null
            ? null
            : DateTime.parse(json["bookingTime"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        clientId: json["clientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
        "bookingTime": bookingTime?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "clientId": clientId,
      };
}
