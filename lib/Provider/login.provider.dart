// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:audio_probe/Dio/api_response.dart';
import 'package:audio_probe/Dio/dio_client.dart';
import 'package:audio_probe/Models/common_res_model.dart';
import 'package:audio_probe/Models/versionmodel.dart';
import 'package:audio_probe/Values/dialogs.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/login/loginscreen.dart';
import 'package:audio_probe/Views/home.dart';
import 'package:audio_probe/Views/noInternetScreen.dart';
import 'package:audio_probe/Views/onboarding/onboarding_screen.dart';
import 'package:audio_probe/Views/update/app_update.dart';
import 'package:audio_probe/Views/update/maintenance.dart';
import 'package:audio_probe/repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import '../Custom/slide_right_route.dart';
import '../Navigation/nav.dart';
import '../Views/login/models/login_model.dart';

class LoginUser with ChangeNotifier {
  final Repo repo;
  final DioClient dioClient;
  final NavigationService ns;
  final SharedPreferences sharedPreferences;
  LoginUser(
      {required this.repo,
      required this.ns,
      required this.dioClient,
      required this.sharedPreferences});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  VersionModel? versionModel;
  StaffLoginRes? staffLoginRes;
  LoginResModel? loginRes;
  Future<void> getVersion() async {
    ApiResponse res = await repo.getData(StringConst.getVersion);
    if (res.response != null && res.response!.statusCode == 200) {
      versionModel = VersionModel.fromJson(res.response!.data);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> checkVersion() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String buildNumber = packageInfo.buildNumber;
      ApiResponse res = await repo.getData(StringConst.getVersion);
      if (res.response != null && res.response!.statusCode == 200) {
        VersionModel versionModel = VersionModel.fromJson(res.response!.data);
        androidGoto(buildNumber, versionModel);
      } else {
        Alerts.showError(res.error);
      }
    } else {
      Navigator.push(ns.getContext(),
          MaterialPageRoute(builder: (context) => const NoInternetScreen()));
    }
  }

  void androidGoto(String buildNumber, VersionModel version) {
    print(buildNumber);
    if (version.status == "Inactive") {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          SlideRightRoute(
              page: AppMaintenance(
                  message:
                      "We're currently performing scheduled maintenance to improve your experience. We'll be back shortly.")),
          (route) => false);
    } else if (int.parse(buildNumber) >=
        int.parse(version.supportingVersion!)) {
      goto();
    } else {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          SlideRightRoute(
              page: AppUpdate(
            message:
                "A new version of App is now available for download. To continue using the app and\nenjoy the latest features and improvements, please update it now.",
            isandroid: true,
          )),
          (route) => false);
    }
  }

  void goto() {
    bool isLoggedIn = sharedPreferences.getBool('isLogged') ?? false;
    bool seenOnboarding = sharedPreferences.getBool('seenOnboarding') ?? false;
    bool isStaff = sharedPreferences.getBool('isStaff') ?? false;
    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          MaterialPageRoute(builder: (context) => HomePage(isStaff: isStaff)),
          (route) => false);
    } else {
      if (seenOnboarding == true) {
        Navigator.pushAndRemoveUntil(
            ns.getContext(),
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            ns.getContext(),
            MaterialPageRoute(builder: (context) => const Onboarding()),
            (route) => false);
      }
    }
  }

  Future<void> login(bool isStaff) async {
    String username = usernameController.text;
    String password = passwordController.text;
    // print("fcm-$fcmToken");
    if (username.isEmpty && password.isEmpty) {
      Alerts.showError("Login credentials are empty");
    } else if (username.isEmpty) {
      Alerts.showError("Username is is not allowed to be empty!");
    } else if (password.isEmpty) {
      Alerts.showError("Password is is not allowed to be empty!");
    } else {
      Dialogs.showLoading();
      ApiResponse res = await repo.postData(
          isStaff ? StringConst.staffLogin : StringConst.login,
          data: {'username': username, 'password': password});
      Navigator.pop(ns.getContext());
      if (res.response != null && res.response!.statusCode == 200) {
        clearControllers();
        if (isStaff) {
          staffLoginRes = StaffLoginRes.fromJson(res.response!.data);
        } else {
          loginRes = LoginResModel.fromJson(res.response!.data);
        }
        dioClient.dio.options.headers = {
          'Authorization':
              isStaff ? staffLoginRes!.accessToken : loginRes!.accessToken
        };
        sharedPreferences.setString("userId",
            isStaff ? staffLoginRes!.id.toString() : loginRes!.id!.toString());
        sharedPreferences.setString(
            "name", isStaff ? "Staff" : loginRes!.name!);
        sharedPreferences.setString(
            "email", isStaff ? "0738888xx00" : loginRes!.email!);
        sharedPreferences.setString(
            "mobile", isStaff ? "audioprobxx@outlook.com" : loginRes!.mobile!);
        sharedPreferences.setString(
            "role", isStaff ? staffLoginRes!.therapist! : loginRes!.role!);
        sharedPreferences.setString("token",
            isStaff ? staffLoginRes!.accessToken! : loginRes!.accessToken!);
        sharedPreferences.setBool("isStaff", isStaff ? true : false);
        sharedPreferences.setBool("isLogged", true);
        Navigator.pushAndRemoveUntil(
            ns.getContext(),
            MaterialPageRoute(builder: (context) => HomePage(isStaff: isStaff)),
            (route) => false);
      } else {
        Alerts.showError2("User not found !");
      }
    }
  }

  Future<void> updatePassword() async {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;
    final userid = sharedPreferences.getString("userId") ?? "";
    if (newPassword.length < 8) {
      Alerts.showError("New password must be at least 8 characters long");
    } else if (newPassword != confirmPassword) {
      Alerts.showError("Enter valid password");
    } else {
      var data = {
        'id': userid,
        'currentPassword': currentPassword,
        'newPassword': confirmPassword
      };
      ApiResponse res =
          await repo.postData(StringConst.updatePassword, data: data);
      if (res.response?.statusCode == 401) {
        Alerts.showError("Invalid Password");
      }
      if (res.response != null && res.response!.statusCode == 200) {
        CommonRes commonRes = CommonRes.fromJson(res.response!.data);
        Alerts.showSuccess(commonRes.message);
        logout();
      } else {
        Alerts.showError(res.error);
      }
    }
  }

  logout() {
    clearControllers();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(ns.getContext(),
        SlideRightRoute(page: const LoginScreen()), (route) => false);
  }

  void clearControllers() {
    usernameController.clear();
    passwordController.clear();
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
