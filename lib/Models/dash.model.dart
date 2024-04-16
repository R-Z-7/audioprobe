class DashModel {
  String? response;
  int? appointmentsToday;

  DashModel({
    this.response,
    this.appointmentsToday,
  });

  factory DashModel.fromJson(Map<String, dynamic> json) => DashModel(
        response: json["response"],
        appointmentsToday: json["appointments_today"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "appointments_today": appointmentsToday,
      };
}
