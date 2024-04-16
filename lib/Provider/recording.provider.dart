// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:audio_probe/Models/analysisSummary.model.dart';
import 'package:audio_probe/Values/dialogs.dart';
import 'package:http_parser/http_parser.dart';
import 'package:audio_probe/Dio/api_response.dart';
import 'package:audio_probe/Dio/dio_client.dart';
import 'package:audio_probe/Models/analysis.model.dart';
import 'package:audio_probe/Navigation/nav.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/tabs/tab2/analyse_screen.dart';
import 'package:audio_probe/repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordingProvider with ChangeNotifier {
  final Repo repo;
  final DioClient dioClient;
  final NavigationService ns;
  final SharedPreferences sharedPreferences;
  RecordingProvider(
      {required this.repo,
      required this.ns,
      required this.dioClient,
      required this.sharedPreferences});

  int _page = 1;
  late int totalPages;
  final int _limit = 15;
  final TextEditingController commentscontrlr = TextEditingController();
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  AnalysisModel? analysisModel;
  late List<RecordedData> recordedData = [];
  // RecordedData? recordedData;
  void toggleRecording() {
    _isRecording = !_isRecording;
    notifyListeners();
  }

  Future<void> analyseAudio({required File file, required String id}) async {
    if (file.existsSync()) {
      final mapData = {
        "audio": await MultipartFile.fromFile(file.path,
            contentType: MediaType('audio', 'wave'))
      };
      print("File Path: ${file.path}");

      var formData = FormData.fromMap(mapData);
      Dialogs.showLoading();
      ApiResponse res = await repo.postData(
        StringConst.ANALYSE_AUDIO,
        data: formData,
      );
      Navigator.pop(ns.getContext());
      print("Response Status Code: ${res.response?.statusCode}");
      print("Response Data: ${res.response?.data}");
      print("Response Content-Type: ${res.response?.headers["content-type"]}");
      if (res.response != null) {
        if (res.response!.statusCode == 200) {
          Alerts.showSuccess("Audio executed and analysed successfully");
          analysisModel = AnalysisModel.fromJson(res.response!.data);
          Navigator.push(
            ns.getContext(),
            MaterialPageRoute(
              builder: (context) => AnalysedScreen(
                analysisData: analysisModel!.data!,
                clientId: id,
              ),
            ),
          );
        } else {
          // Handle other status codes here
          Alerts.showError(
              "Failed to analyze audio. Server returned an error.");
        }
      } else {
        // Handle null response here
        Alerts.showError("Failed to analyze audio. No response from server.");
      }
      notifyListeners();
    } else {
      Alerts.showError("File does not exist at path: ${file.path}");
    }
  }

  final RefreshController refreshCntrlr =
      RefreshController(initialRefresh: true);
  Future getlistofRecords(
      {bool isRefresh = false,
      required BuildContext context,
      required String clientid}) async {
    if (isRefresh) {
      _page = 1;
    } else {
      if (_page >= totalPages) {
        refreshCntrlr.loadNoData();
        return false;
      }
    }
    final data = {"id": clientid};
    ApiResponse? res = await repo.getData(
        "${StringConst.FETCH_ANALYSIS_RECORD}?page=$_page&size=$_limit",
        data: data);
    if (res.response?.data != null && res.response!.statusCode == 200) {
      final recordedModel = AnalysisSummary.fromJson(res.response?.data);
      if (isRefresh) {
        recordedData = recordedModel.data!;
      } else {
        recordedData.addAll(recordedModel.data!);
      }
      _page++;
      totalPages = recordedModel.totalPages!;
      notifyListeners();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveRecord(
      {required BuildContext context,
      required AnalysisData anlyticdata,
      required String clientId}) async {
    final Map<String, dynamic> data = {
      "analysis_data": anlyticdata,
      "comments": commentscontrlr.text ?? "",
      "clientId": clientId,
    };
    ApiResponse? res =
        await repo.postData(StringConst.ADD_ANALYSIS, data: jsonEncode(data));
    if (res.response?.data["response"] == "success" &&
        res.response?.statusCode == 200) {
      clearControllers();
      Alerts.showSuccess(res.response?.data["message"]);
      Navigator.pop(context, true);
    } else if (res.error != "401") {
      clearControllers();
      Alerts.showError(res.error);
    }
  }

  void clearControllers() {
    commentscontrlr.clear();
  }
}
