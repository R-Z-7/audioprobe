// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';
import 'package:audio_probe/Dio/api_response.dart';
import 'package:audio_probe/Dio/dio_client.dart';
import 'package:audio_probe/Models/availability.model.dart';
import 'package:audio_probe/Models/booking.model.dart';
import 'package:audio_probe/Models/clients.model.dart';
import 'package:audio_probe/Models/dash.model.dart';
import 'package:audio_probe/Navigation/nav.dart';
import 'package:audio_probe/Utils/time_utils.dart';
import 'package:audio_probe/Values/dialogs.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/tabs/tab3/tab3.dart';
import 'package:audio_probe/repo.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingProvider with ChangeNotifier {
  final Repo repo;
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  final NavigationService ns;
  BookingProvider({
    required this.dioClient,
    required this.repo,
    required this.sharedPreferences,
    required this.ns,
  });
  int _page = 1;
  late int totalPages;
  final int _limit = 15;
  BookingModel? bookingModel;
  DashModel? dashModel;
  List<BookingData> timeSheet = [];
  List<Meeting> meetings = [];
  late List<AvailabilityData> availabilityData = [];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController fNController = TextEditingController();
  final TextEditingController lNController = TextEditingController();
  final TextEditingController aDController = TextEditingController();
  final TextEditingController aGController = TextEditingController();
  final TextEditingController slotcontroller = TextEditingController();
  final TextEditingController controllerdate = TextEditingController();

  Future<void> getMonthlyAttendance(
      String month, String year, String startdate, String enddate) async {
    meetings = [];
    Dialogs.showLoading();
    var filterbyWeek =
        startdate != "" ? "&startdate=$startdate&enddate=$enddate" : "";
    ApiResponse res = await repo.getData(
        "${StringConst.GET_MONTHLYnWEEKLY_APPOINTMENTS}?month=$month&year=$year" +
            filterbyWeek);
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      bookingModel = BookingModel.fromJson(res.response!.data);
      timeSheet = bookingModel!.data!;
      meetings = getDataSource(timeSheet);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  List<Meeting> getDataSource(List<BookingData> timeSheet) {
    final List<Meeting> meetings = <Meeting>[];
    for (var time in timeSheet) {
      final DateTime today = time.bookingTime!;
      final DateTime startTime = DateTime(
          today.year, today.month, today.day, today.hour, today.minute);
      meetings.add(
          Meeting('', startTime, startTime, const Color(0xFF0F8644), true));
    }
    return meetings;
  }

  Future<void> addPatients(
      {required BuildContext context,
      required int userId,
      required String firstname,
      required String lastname,
      required String gender,
      required String age,
      required String mobile,
      required String address,
      required int eventid}) async {
    final Map<String, dynamic> data = {
      "firstName": firstname,
      "lastName": lastname,
      "gender": gender,
      "age": age,
      "mobile": mobile,
      "address": address,
      "userId": userId
    };
    ApiResponse? res =
        await repo.postData(StringConst.ADD_CLIENT, data: jsonEncode(data));
    if (res.response?.data["response"] == "success" &&
        res.response?.statusCode == 200) {
      Alerts.showSuccess(res.response?.data["message"]);
      Navigator.pop(context, true);
    } else if (res.error != "401") {
      Alerts.showError(res.error);
    }
  }

  Future<void> getDashboard() async {
    ApiResponse res = await repo.getData(StringConst.getDashboard);
    if (res.response != null && res.response!.statusCode == 200) {
      dashModel = DashModel.fromJson(res.response!.data);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> addAvailability({
    required BuildContext context,
    required String date,
    required String slots,
  }) async {
    var userId = sharedPreferences.getString("userId") ?? "";
    final Map<String, dynamic> data = {
      "date": date,
      "slots": slots,
      "availableSlots": slots,
      "userId": userId
    };
    ApiResponse? res = await repo.postData(StringConst.ADD_AVAILABILITY,
        data: jsonEncode(data));
    if (res.response?.data["response"] == "success" &&
        res.response?.statusCode == 200) {
      Alerts.showSuccess(res.response?.data["message"]);
      Navigator.pop(context, true);
    } else if (res.error != "401") {
      Alerts.showError(res.error);
    }
  }

  Future<void> addAppointments({
    required BuildContext context,
    required String bookingTime,
    required String clientId,
  }) async {
    var userId = sharedPreferences.getString("userId") ?? "";
    final Map<String, dynamic> data = {
      "bookingTime": bookingTime,
      "clientId": clientId,
      "userId": userId
    };
    ApiResponse? res =
        await repo.postData(StringConst.ADD_BOOKING, data: jsonEncode(data));
    if (res.response?.data["response"] == "success" &&
        res.response?.statusCode == 200) {
      Alerts.showSuccess(res.response?.data["message"]);
      Navigator.pop(context, true);
    } else {
      Alerts.showError2(res.response?.data["message"]);
    }
  }

  Future getlistofAvailabilities({
    bool isRefresh = false,
    required RefreshController refreshController,
    required BuildContext context,
  }) async {
    var search = searchController.text;
    if (isRefresh) {
      _page = 1;
    } else {
      if (_page >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    ApiResponse? res = await repo
        .getData("${StringConst.getAvailability}?page=$_page&size=$_limit");
    if (res.response?.data != null && res.response!.statusCode == 200) {
      final availabilityModel = AvailabilityModel.fromJson(res.response?.data);
      if (isRefresh) {
        availabilityData = availabilityModel.data!;
      } else {
        availabilityData.addAll(availabilityModel.data!);
      }
      _page++;
      totalPages = availabilityModel.totalPages!;
      notifyListeners();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  clearControllers() {
    slotcontroller.clear();
    searchController.clear();
    notifyListeners();
  }
}
