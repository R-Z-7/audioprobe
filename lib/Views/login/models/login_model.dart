class LoginResModel {
  String? response;
  String? message;
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? roleId;
  String? role;
  String? accessToken;
  String? expiresIn;

  LoginResModel({
    this.response,
    this.message,
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.roleId,
    this.role,
    this.accessToken,
    this.expiresIn,
  });

  factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
        response: json["response"],
        message: json["message"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        roleId: json["roleId"],
        role: json["role"],
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "roleId": roleId,
        "role": role,
        "access_token": accessToken,
        "expires_in": expiresIn,
      };
}

class StaffLoginRes {
  String? response;
  String? message;
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? therapistId;
  String? therapist;
  String? accessToken;
  String? expiresIn;

  StaffLoginRes({
    this.response,
    this.message,
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.therapistId,
    this.therapist,
    this.accessToken,
    this.expiresIn,
  });

  factory StaffLoginRes.fromJson(Map<String, dynamic> json) => StaffLoginRes(
        response: json["response"],
        message: json["message"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        therapistId: json["therapistId"],
        therapist: json["therapist"],
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "message": message,
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "therapistId": therapistId,
        "therapist": therapist,
        "access_token": accessToken,
        "expires_in": expiresIn,
      };
}
