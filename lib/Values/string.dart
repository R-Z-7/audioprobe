// ignore_for_file: constant_identifier_names

part of Values;

class StringConst {
  static const String baseUrl =
      "https://audioprobe-8564ebe8f3b8.herokuapp.com/api/";
  // static const String baseUrl = "http://192.168.0.208:3000/api/";

  //version
  static const String getVersion = "getVersion";

  //auth
  static const String login = "auth/sign_in";
  static const String updatePassword = "users/update_password";

  //clients
  static const String LIST_OF_CLIENTS = "clients/list_of_clients";
  static const String ADD_CLIENT = "clients/add_client";
  static const String checkOut = "attendance/checkOut";
  static const String getMonthlyAttendance = "attendance/getMonthlyAttendance";
  static const String getWeeklyAttendance = "attendance/getWeeklyAttendance";

  //appointments
  static const String GET_MONTHLYnWEEKLY_APPOINTMENTS =
      "appointments/list_of_appointments";
  static const String ADD_BOOKING = "appointments/add_appointments";

  //dashboard
  static const String getDashboard = "get_dashboard";

  //staff
  static const String staffLogin = "staff/sign_in";

  // analysis audio
  static const String ANALYSE_AUDIO = "audio/get_analysis";
  static const String ADD_ANALYSIS = "analysis/add_analysis";
  static const String FETCH_ANALYSIS_RECORD = "analysis/list_of_analysis";

  //availability
  static const String getAvailability = "availability/list_of_availability";
  static const String ADD_AVAILABILITY = "availability/add_availability";

  static const String updateProfileDetails = "profile/updateProfileDetails";
}
