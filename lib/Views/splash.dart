// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:after_layout/after_layout.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Provider/login.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({
    Key? key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    afterFirstLayout(context);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    LoginUser authProvider = Provider.of<LoginUser>(context, listen: false);
    authProvider.checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: MediaQuery.of(context).size.width / 2,
              height: 250.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customText(
                  text: "Audio Probe",
                  id: 1,
                  textSize: Sizes.TEXT_SIZE_30,
                  weight: FontWeight.w700,
                  color: AppColors.primaryDarkColor,
                ),
              ],
            )
          ],
        ));
  }
}
