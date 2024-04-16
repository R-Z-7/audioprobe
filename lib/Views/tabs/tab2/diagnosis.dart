// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:audio_probe/Custom/avatar.dart';
import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/custom_textfield.dart';
import 'package:audio_probe/Custom/customfooter.dart';
import 'package:audio_probe/Provider/recording.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/tabs/tab2/analyse_screen.dart';
import 'package:audio_probe/Views/tabs/tab2/recordedData.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Diagnosis extends StatefulWidget {
  final String clientId;
  const Diagnosis({super.key, required this.clientId});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecordingProvider>(context, listen: false)
          .getlistofRecords(context: context, clientid: widget.clientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<RecordingProvider>(builder: (context, provider, child) {
      return BaseWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColors.white10),
                      child: IconButton(
                        icon: Icon(Iconsax.arrow_left_2),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: AppColors.hint,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        height: 50.0,
                        fit: BoxFit.fitHeight,
                        alignment: Alignment(0.00, 0.00),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  customText(
                    text: "Analysis Summary",
                    id: 1,
                    textSize: 21,
                  )
                ],
              ),
              Divider(height: 4),
              Expanded(
                  child: SmartRefresher(
                      controller: provider.refreshCntrlr,
                      enablePullUp: true,
                      enablePullDown: true,
                      footer: const CustomFooter2(),
                      onRefresh: () async {
                        final result = await provider.getlistofRecords(
                            context: context,
                            isRefresh: true,
                            clientid: widget.clientId);
                        if (result) {
                          provider.refreshCntrlr.refreshCompleted();
                        } else {
                          provider.refreshCntrlr.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result2 = await provider.getlistofRecords(
                            context: context, clientid: widget.clientId);
                        if (result2) {
                          provider.refreshCntrlr.loadComplete();
                        } else {
                          provider.refreshCntrlr.loadFailed();
                        }
                      },
                      child: provider.recordedData == null
                          ? SizedBox(
                              height: size.height * 0.6,
                              child: Center(
                                  child: SpinKitChasingDots(
                                      color: AppColors.primaryColor,
                                      size: 50.0,
                                      duration:
                                          const Duration(milliseconds: 1200))),
                            )
                          : provider.recordedData.isEmpty
                              ? EmptyWidget(
                                  packageImage: PackageImage.Image_3,
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    final recordedData =
                                        provider.recordedData[index];
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecAnalysisScreen(
                                                      analysisData: recordedData
                                                          .analysisData!,
                                                      date:
                                                          DateFormat(
                                                                  "dd-MM-yyyy")
                                                              .format(recordedData
                                                                  .createdAt!),
                                                      comments: recordedData
                                                              .comments ??
                                                          "",
                                                      clientId:
                                                          widget.clientId))),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          elevation: 2,
                                          child: Container(
                                              height: 100,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      AppColors
                                                          .primaryDarkColor,
                                                      AppColors.primaryDarkColor
                                                          .withOpacity(.5),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomCenter,
                                                    stops: const [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(children: [
                                                              CircleAvatar(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .white10
                                                                          .withOpacity(
                                                                              .3),
                                                                  radius: 30,
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    "assets/images/speech.svg",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  customText(
                                                                      text: DateFormat("dd-MM-yyyy").format(
                                                                          recordedData
                                                                              .createdAt!),
                                                                      textSize:
                                                                          19,
                                                                      weight: FontWeight
                                                                          .bold,
                                                                      color: AppColors
                                                                          .white10
                                                                          .withOpacity(
                                                                              .7),
                                                                      id: 1),
                                                                  customText(
                                                                    text:
                                                                        "ID - #${recordedData.id}",
                                                                    id: 1,
                                                                    textSize:
                                                                        15,
                                                                    weight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                            Icon(
                                                              Iconsax
                                                                  .arrow_right_15,
                                                              color: AppColors
                                                                  .primaryDarkColor
                                                                  .withOpacity(
                                                                      .6),
                                                            )
                                                          ],
                                                        ),
                                                      ])))),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 4,
                                      ),
                                  itemCount: provider.recordedData.length != 0
                                      ? provider.recordedData.length
                                      : 0)))
            ],
          ),
        ),
      );
    });
  }
}
