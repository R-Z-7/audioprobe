class ClientsModel {
  String? response;
  int? totalCount;
  List<Datum>? data;
  int? totalPages;
  int? currentPage;

  ClientsModel({
    this.response,
    this.totalCount,
    this.data,
    this.totalPages,
    this.currentPage,
  });

  factory ClientsModel.fromJson(Map<String, dynamic> json) => ClientsModel(
        response: json["response"],
        totalCount: json["totalCount"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  int? id;
  String? firstName;
  String? lastName;
  String? gender;
  int? age;
  String? mobile;
  String? address;
  DateTime? updatedAt;
  int? userId;

  Datum({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.age,
    this.mobile,
    this.address,
    this.updatedAt,
    this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        age: json["age"],
        mobile: json["mobile"],
        address: json["address"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "age": age,
        "mobile": mobile,
        "address": address,
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };
}
