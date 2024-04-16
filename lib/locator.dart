import 'package:audio_probe/Navigation/nav.dart';
import 'package:audio_probe/Provider/booking.provider.dart';
import 'package:audio_probe/Provider/clients.provider.dart';
import 'package:audio_probe/Provider/login.provider.dart';
import 'package:audio_probe/Provider/profile.provider.dart';
import 'package:audio_probe/Provider/recording.provider.dart';
import 'package:audio_probe/repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dio/dio_client.dart';
import 'Dio/log_interceptor.dart';

final loc = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  loc.registerLazySingleton(() => sharedPreferences);
  loc.registerLazySingleton(() => Dio());
  loc.registerLazySingleton(() => LoggingInterceptor());
  loc.registerLazySingleton(() => NavigationService());

  // loc.registerLazySingleton(() => UserPreferences());
  loc.registerLazySingleton(() => DioClient(
        // StringConst.BASE_URL,
        "",
        loc(),
        loggingInterceptor: loc(),
        sharedPreferences: loc(),
        navigationService: loc(),
      ));

  // Repository
  loc.registerLazySingleton(
      () => Repo(sharedPreferences: loc(), dioClient: loc()));

  // provider
  loc.registerFactory(() => LoginUser(
        sharedPreferences: loc(),
        dioClient: loc(),
        repo: loc(),
        ns: loc(),
      ));
  loc.registerFactory(() => ProfileProvider(
        sharedPreferences: loc(),
        dioClient: loc(),
        repo: loc(),
        ns: loc(),
      ));
  loc.registerFactory(() => RecordingProvider(
        sharedPreferences: loc(),
        dioClient: loc(),
        repo: loc(),
        ns: loc(),
      ));
  loc.registerFactory(() => PatientsProvider(
      repo: loc(), ns: loc(), dioClient: loc(), sharedPreferences: loc()));
      loc.registerFactory(() => BookingProvider(
      repo: loc(), ns: loc(), dioClient: loc(), sharedPreferences: loc()));
}
