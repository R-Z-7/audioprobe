// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:audio_probe/Navigation/nav.dart';
import 'package:audio_probe/Provider/booking.provider.dart';
import 'package:audio_probe/Provider/clients.provider.dart';
import 'package:audio_probe/Provider/login.provider.dart';
import 'package:audio_probe/Provider/profile.provider.dart';
import 'package:audio_probe/Provider/recording.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'locator.dart' as ltr;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ltr.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => ltr.loc<LoginUser>()),
            ChangeNotifierProvider(create: (_) => ltr.loc<ProfileProvider>()),
            ChangeNotifierProvider(create: (_) => ltr.loc<RecordingProvider>()),
            ChangeNotifierProvider(create: (_) => ltr.loc<PatientsProvider>()),
            ChangeNotifierProvider(create: (_) => ltr.loc<BookingProvider>())
          ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(primaryColor: AppColors.primaryDarkColor),
        navigatorKey: NavigationService.navigatorKey,
        title: 'Audio Probe',
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
