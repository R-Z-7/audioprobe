// ignore_for_file: use_build_context_synchronously

import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/slide_right_route.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: "Get started",
        centerBackground: true,
        controllerColor: AppColors.hint.withOpacity(.2),
        finishButtonStyle: FinishButtonStyle(
            backgroundColor: AppColors.primaryDarkColor, elevation: 3),
        skipTextButton: const Text('Skip'),
        trailing: const Text(''),
        onFinish: () async {
          final sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setBool('seenOnboarding', true);
          Navigator.pushAndRemoveUntil(context,
              SlideRightRoute(page: const LoginScreen()), (route) => false);
        },
        background: [
          Image.asset('assets/images/logo.jpg'),
          Image.asset('assets/images/logo.jpg'),
          Image.asset('assets/images/logo.jpg'),
          Image.asset('assets/images/logo.jpg'),
        ],
        totalPage: 4,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 420,
                ),
                customText(
                  text: 'Welcome to\n  Audio Probe, ',
                  id: 2,
                  weight: FontWeight.bold,
                  textSize: 19,
                  align: TextAlign.center,
                ),
                customText(
                  align: TextAlign.center,
                  text: '',
                  id: 2,
                  weight: FontWeight.bold,
                  textSize: 17,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    textSize: 17,
                    align: TextAlign.center,
                    text: '',
                    id: 2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    textSize: 17,
                    text: '',
                    id: 2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    textSize: 17,
                    text: '',
                    id: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
