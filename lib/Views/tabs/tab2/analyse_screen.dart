// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Custom/celevatedbutton.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/custom_textfield.dart';
import 'package:audio_probe/Custom/systempadding.dart';
import 'package:audio_probe/Models/analysis.model.dart';
import 'package:audio_probe/Provider/login.provider.dart';
import 'package:audio_probe/Provider/recording.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AnalysedScreen extends StatefulWidget {
  final AnalysisData analysisData;
  final String clientId;
  const AnalysedScreen(
      {super.key, required this.analysisData, required this.clientId});

  @override
  State<AnalysedScreen> createState() => _AnalysedScreenState();
}

class _AnalysedScreenState extends State<AnalysedScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, provider, child) {
      return BaseWidget(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
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
                    Text(
                      "AudioProbe",
                      style: GoogleFonts.lato(
                        color: AppColors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                customText(
                  text: "Analysed Speech Results powered by praat",
                  id: 1,
                  textSize: 18,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Table(
                            columnWidths: {
                              0: FractionColumnWidth(0.5),
                              1: FractionColumnWidth(0.3)
                            },
                            border: TableBorder.all(), // Add borders to cells
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Center(child: Text('Meanlocaljitter')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanlocaljitter
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text('Meanlocalabsolute')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanlocalabsolute
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanrap')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.meanrap
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanppq5')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.meanppq5
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanddp')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.meanddp
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Center(child: Text('Meanlocalshimmer')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanlocalshimmer
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanlocaldb')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanlocaldb
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanapq3')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.meanapq3
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanaqpq5')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanaqpq5
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanapq11')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanapq11
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meandda')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.meandda
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meanpitch')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meanpitch
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Meansdpitch')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meansdpitch
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Minpitch')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.minpitch
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('Maxpitch')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.maxpitch
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('MeanHNR')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.meanHnr
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('MeansdHNR')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget
                                                .analysisData.meansdHnr
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('f1')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.f1
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('f2')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.f2
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('f3')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.f3
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                              TableRow(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor.withOpacity(.4),
                                        AppColors.primaryColor.withOpacity(.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                children: [
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('f4')),
                                  )),
                                  TableCell(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(widget.analysisData.f4
                                                ?.substring(0, 7) ??
                                            '')),
                                  )),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CElevatedButton(
                                          onpressed: () =>
                                              saveToRecords(provider, context),
                                          color: AppColors.primaryDarkColor,
                                          size: Size(170, 50),
                                          text: Text(
                                            "Save",
                                            style: GoogleFonts.poppins(
                                                color: AppColors.white,
                                                fontSize: Sizes.TEXT_SIZE_22),
                                          )),
                                    ),
                                  ]))
                        ],
                      ),
                    ],
                  ),
                ),
              ])));
    });
  }

  Future<void> saveToRecords(RecordingProvider provider, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showGeneralDialog(
        context: context,
        barrierLabel: "SaveTo Patient's Records",
        barrierDismissible: true,
        // barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (filtercontext, __, ___) {
          return StatefulBuilder(builder: (context, setState) {
            return Material(
              color: Colors.transparent,
              child: SystemPadding(
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 13,
                              ),
                              Container(
                                color: AppColors.white10,
                                height: 45.0,
                                width: size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Confirm Save",
                                        style: GoogleFonts.poppins(
                                            color: AppColors.hint,
                                            fontSize: Sizes.TEXT_SIZE_22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Are you sure you want to save the analysis report to this user's records?",
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.black,
                                            fontSize: Sizes.TEXT_SIZE_18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: CustomTextFormField(
                                          controller: provider.commentscontrlr,
                                          hint: "Comments(Optional)",
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 12.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: CElevatedButton(
                                          onpressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: AppColors.white,
                                          size: Size(170, 50),
                                          text: Text(
                                            "Cancel",
                                            style: GoogleFonts.poppins(
                                                color:
                                                    AppColors.primaryDarkColor,
                                                fontSize: Sizes.TEXT_SIZE_22),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CElevatedButton(
                                          onpressed: () {
                                            provider.saveRecord(
                                                context: context,
                                                anlyticdata:
                                                    widget.analysisData,
                                                clientId: widget.clientId);
                                          },
                                          color: AppColors.primaryDarkColor,
                                          size: Size(0, 50),
                                          text: Text(
                                            "Save",
                                            style: GoogleFonts.poppins(
                                                color: AppColors.white,
                                                fontSize: Sizes.TEXT_SIZE_22),
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )))),
            );
          });
        });
  }
}
