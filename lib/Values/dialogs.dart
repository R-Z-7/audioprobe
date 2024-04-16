import '../Custom/ctext.dart';
import '../Custom/texts.dart';
import '../Navigation/nav.dart';
import '../values/values.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class Dialogs {
  static showLoading() {
    showDialog(
      barrierColor: Colors.black38,
      barrierDismissible: false,
      context: GetIt.I<NavigationService>().getContext(),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                    child: Container(
                  decoration: Decorations.boxDecorationColorBorder(
                      color: Colors.white, borderRadius: 4.0),
                  height: 40.0,
                  width: 96.0,
                )),
                Center(
                    child: Lottie.asset(
                  'assets/lotties/loading.json',
                  width: 96.0,
                  fit: BoxFit.fitWidth,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  static showLoading2(BuildContext context) {
    showDialog(
      barrierColor: Colors.black38,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                    child: Container(
                  decoration: Decorations.boxDecorationColorBorder(
                      color: Colors.white, borderRadius: 4.0),
                  height: 40.0,
                  width: 96.0,
                )),
                Center(
                    child: Lottie.asset(
                  'assets/lottie/loading.json',
                  width: 96.0,
                  fit: BoxFit.fitWidth,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  static showAlertDialog(
      {required BuildContext context,
      required String title,
      String? subTitle,
      required VoidCallback yesClick}) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CText(
              text: title,
              textcolor: AppColors.primaryDarkColor,
              fontw: FontWeight.bold,
              size: 19,
            ),
            Divider(
              height: 2,
              color: AppColors.primaryDarkColor,
            ),
          ],
        ),
        content: CText(
          text: subTitle ?? "",
          textcolor: AppColors.hint,
          fontw: FontWeight.w600,
          size: 16,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("NO")),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                yesClick();
              },
              child: const Text("YES")),
        ],
      ),
    );
  }

  static showAlertDialog2(
      {required BuildContext context,
      required String title,
      String? subTitle,
      required VoidCallback yesClick}) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CText(
              text: title,
              textcolor: AppColors.primaryDarkColor,
              fontw: FontWeight.bold,
              size: 19,
            ),
            Divider(
              height: 2,
              color: AppColors.primaryDarkColor,
            ),
          ],
        ),
        content: Texts.regular(subTitle),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                yesClick();
              },
              child: const Text("YES")),
        ],
      ),
    );
  }
}
