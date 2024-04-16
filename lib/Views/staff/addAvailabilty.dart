// ignore_for_file: prefer_is_empty, prefer_const_constructors

import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/custom_textfield.dart';
import 'package:audio_probe/Custom/customfooter.dart';
import 'package:audio_probe/Custom/systempadding.dart';
import 'package:audio_probe/Custom/widgets/custom_dropdown.dart';
import 'package:audio_probe/Models/availability.model.dart';
import 'package:audio_probe/Provider/booking.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAvailability extends StatefulWidget {
  const AddAvailability({super.key});

  @override
  State<AddAvailability> createState() => _AddAvailabilityState();
}

class _AddAvailabilityState extends State<AddAvailability> {
  String name = "";
  final List _daylist = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  String? selectedValue;
  Future<void> setProfileData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name")!;
    });
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay? starttime;
  String formattedfinishDateTime = "";
  String formattedstartDateTime = "";
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final RefreshController refreshCntrlr =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setProfileData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false)
          .getlistofAvailabilities(
              context: context, refreshController: refreshCntrlr);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<BookingProvider>(builder: (context, provider, child) {
      return BaseWidget(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              addAvailability(size, provider)
                  .then((value) => refreshCntrlr.requestRefresh());
            },
            backgroundColor: AppColors.primaryDarkColor,
            child: const Icon(
              Iconsax.note_add,
              color: AppColors.white,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                // SizedBox(height: 25),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Align(
                      alignment: const AlignmentDirectional(0.00, -1.00),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          height: 50.0,
                          fit: BoxFit.fitHeight,
                          alignment: const Alignment(0.00, 0.00),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Audio Probe",
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
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 3,
                  child: Container(
                      height: 120,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                            colors: [
                              AppColors.primaryDarkColor,
                              AppColors.primaryDarkColor.withOpacity(.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Day 👋",
                                style: GoogleFonts.lato(
                                  color: AppColors.white10.withOpacity(.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Column(children: [
                                AutoSizeText(
                                  name,
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.white10,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minFontSize: 17,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Expanded(
                                  child: Container(
                                    color: AppColors.dark,
                                    height: 1.0,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDarkColor,
                                  ),
                                  child: customText(
                                      text: DateFormat('dd MMMM yyy')
                                          .format(DateTime.now()),
                                      id: 1,
                                      textSize: 19,
                                      color: AppColors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  color: AppColors.primaryDarkColor,
                                  width: 10,
                                  height: 33,
                                ),
                              ])
                            ]),
                      )),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    controller: provider.searchController,
                    onChanged: (String value) {
                      setState(() {
                        value = provider.searchController.text;
                      });
                      refreshCntrlr.requestRefresh(needMove: false);
                    },
                    hint: 'Search Availability by Date ..',
                    color: AppColors.hint,
                  ),
                ),
                Divider(height: 4),
                Expanded(
                    child: SmartRefresher(
                        controller: refreshCntrlr,
                        enablePullUp: true,
                        enablePullDown: true,
                        footer: const CustomFooter2(),
                        onRefresh: () async {
                          final result = await provider.getlistofAvailabilities(
                              context: context,
                              isRefresh: true,
                              refreshController: refreshCntrlr);
                          if (result) {
                            refreshCntrlr.refreshCompleted();
                          } else {
                            refreshCntrlr.refreshFailed();
                          }
                        },
                        onLoading: () async {
                          final result2 =
                              await provider.getlistofAvailabilities(
                                  context: context,
                                  refreshController: refreshCntrlr);
                          if (result2) {
                            refreshCntrlr.loadComplete();
                          } else {
                            refreshCntrlr.loadFailed();
                          }
                        },
                        child: provider.availabilityData == null
                            ? SizedBox(
                                height: size.height * 0.6,
                                child: Center(
                                    child: SpinKitChasingDots(
                                        color: AppColors.primaryColor,
                                        size: 50.0,
                                        duration: const Duration(
                                            milliseconds: 1200))),
                              )
                            : provider.availabilityData.isEmpty
                                ? EmptyWidget(
                                    packageImage: PackageImage.Image_3,
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      final availability =
                                          provider.availabilityData[index];
                                      return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          elevation: 2,
                                          child: Container(
                                              height: 110,
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
                                                                      CircleAvatar(
                                                                    backgroundColor: AppColors
                                                                        .white10
                                                                        .withOpacity(
                                                                            .7),
                                                                    radius: 26,
                                                                    child: Icon(
                                                                      Iconsax
                                                                          .activity,
                                                                    ),
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
                                                                      text:
                                                                          "${DateFormat("dd-MM-yyyy").add_EEEE().format(availability.date!)}",
                                                                      textSize:
                                                                          17,
                                                                      weight: FontWeight
                                                                          .bold,
                                                                      color: AppColors
                                                                          .white10
                                                                          .withOpacity(
                                                                              .7),
                                                                      id: 1),

                                                                  customText(
                                                                    text:
                                                                        "Total: ${availability.slots}",
                                                                    id: 1,
                                                                    textSize:
                                                                        29,
                                                                    weight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                  customText(
                                                                    text:
                                                                        "Available slots: ${availability.availableSlots}",
                                                                    id: 1,
                                                                    textSize:
                                                                        23,
                                                                    weight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .black,
                                                                  ),
                                                                  // customText(
                                                                  //   text:
                                                                  //       "Time: ${DateFormat.Hm().format(availability.startTime!)} - ${DateFormat.Hm().format(availability.endTime!)}",
                                                                  //   id: 1,
                                                                  //   textSize:
                                                                  //       15,
                                                                  //   color: AppColors
                                                                  //       .black,
                                                                  // ),
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
                                                      ]))));
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 4,
                                        ),
                                    itemCount:
                                        provider.availabilityData.length != 0
                                            ? provider.availabilityData.length
                                            : 0)))
              ])));
    });
  }

  Future addAvailability(Size size, BookingProvider bookingProvider) {
    return showGeneralDialog(
        context: context,
        barrierLabel: "Add Availability",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (filtercontext, __, ___) {
          return StatefulBuilder(builder: (context, setState) {
            return SystemPadding(
                child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Material(
                              child: Row(
                            children: [
                              Icon(
                                Iconsax.activity,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              customText(
                                  textSize: 18,
                                  weight: FontWeight.bold,
                                  text: "Add Availabilty",
                                  id: 1),
                            ],
                          )),
                          Divider(),
                          Material(
                            color: AppColors.white,
                            child: TextFormField(
                              readOnly: true,
                              controller: bookingProvider.controllerdate,
                              keyboardType: TextInputType.number,
                              onTap: () =>
                                  _selectdate(context, bookingProvider),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                labelText: 'Date',
                                labelStyle: TextStyle(fontSize: 16.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            color: AppColors.white,
                            child: TextFormField(
                              controller: bookingProvider.slotcontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                labelText: 'Number of Slots',
                                labelStyle: TextStyle(fontSize: 16.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          SizedBox(height: 15),
                          Divider(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  child: Container(
                                    height: 55.0,
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        bookingProvider.clearControllers();
                                      },
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.cancel_outlined,
                                              color: AppColors.white,
                                            ),
                                            SizedBox(
                                              width: 7.0,
                                            ),
                                            customText(
                                                text: "Cancel",
                                                id: 1,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Container(
                                        height: 55.0,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: MaterialButton(
                                            onPressed: () {
                                              ;
                                              bookingProvider
                                                  .addAvailability(
                                                      context: context,
                                                      date: selectedDate
                                                          .toString(),
                                                      slots: bookingProvider
                                                          .slotcontroller.text)
                                                  .then((value) {
                                                refreshCntrlr.requestRefresh(
                                                    needMove: false);
                                                bookingProvider
                                                    .clearControllers();
                                              });
                                            },
                                            color: AppColors.primaryDarkColor
                                                .withOpacity(0.8),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .check_circle_outline_outlined,
                                                    color: AppColors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 7.0,
                                                  ),
                                                  customText(
                                                      text: "Add",
                                                      id: 1,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ))))
                              ])
                        ]))));
          });
        });
  }

  Future<void> _selectdate(
      BuildContext context, BookingProvider bookingProvider) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Default date
        firstDate: DateTime(2024), // Minimum selectable date
        lastDate: DateTime(2050));
    print(date);
    if (date != null) {
      setState(() {
        selectedDate = date;
        bookingProvider.controllerdate.text =
            DateFormat('dd-MM-yyyy').format(date);
      });
    }
  }
}
