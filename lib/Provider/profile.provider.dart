// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:audio_probe/Dio/dio_client.dart';

import 'package:audio_probe/Navigation/nav.dart';
import 'package:audio_probe/repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  final Repo repo;
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  final NavigationService ns;
  ProfileProvider({
    required this.dioClient,
    required this.repo,
    required this.sharedPreferences,
    required this.ns,
  });
  // ProfileModel? profileModel;
 

  // Future<void> getProData() async {
  //   ApiResponse res = await repo.getData(StringConst.getProfile);
  //   if (res.response != null && res.response!.statusCode == 200) {
  //     profileModel = ProfileModel.fromJson(res.response!.data);
  //     notifyListeners();
  //   } else {
  //     Alerts.showError(res.error);
  //   }
  // }
}
