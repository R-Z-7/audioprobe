// ignore_for_file: prefer_const_constructors

import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Provider/clients.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:audio_probe/Custom/avatar.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/custom_textfield.dart';
import 'package:audio_probe/Custom/customfooter.dart';
import 'package:audio_probe/Custom/systempadding.dart';
import 'package:audio_probe/Custom/widgets/custom_dropdown.dart';
import 'package:audio_probe/Views/tabs/tab2/detailscreen.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddPatients extends StatefulWidget {
  const AddPatients({super.key});

  @override
  State<AddPatients> createState() => _AddPatientsState();
}

class _AddPatientsState extends State<AddPatients> {
  final List _genderlist = ["Male", "Female", "Other"];
  String? selectedValue;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientsProvider>(context, listen: false)
          .getlistofPatients(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<PatientsProvider>(builder: (context, provider, child) {
      return BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () => addPatient(size, provider),
          backgroundColor: AppColors.primaryDarkColor,
          child: Icon(
            Iconsax.add,
            color: AppColors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // SizedBox(height: 25),
              Row(
                children: [
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
                    "Patients",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: provider.searchController,
                  onChanged: (String value) {
                    setState(() {
                      value = provider.searchController.text;
                    });
                    provider.refreshCntrlr.requestRefresh(needMove: false);
                  },
                  hint: 'Search Patients by Name,Id..',
                  color: AppColors.hint,
                ),
              ),
              Divider(height: 4),
              Expanded(
                  child: SmartRefresher(
                      controller: provider.refreshCntrlr,
                      enablePullUp: true,
                      enablePullDown: true,
                      footer: const CustomFooter2(),
                      onRefresh: () async {
                        final result = await provider.getlistofPatients(
                          context: context,
                          isRefresh: true,
                        );
                        if (result) {
                          provider.refreshCntrlr.refreshCompleted();
                        } else {
                          provider.refreshCntrlr.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result2 =
                            await provider.getlistofPatients(context: context);
                        if (result2) {
                          provider.refreshCntrlr.loadComplete();
                        } else {
                          provider.refreshCntrlr.loadFailed();
                        }
                      },
                      child: provider.patientdata == null
                          ? SizedBox(
                              height: size.height * 0.6,
                              child: Center(
                                  child: SpinKitChasingDots(
                                      color: AppColors.primaryColor,
                                      size: 50.0,
                                      duration:
                                          const Duration(milliseconds: 1200))),
                            )
                          : provider.patientdata.isEmpty
                              ? EmptyWidget(
                                  packageImage: PackageImage.Image_3,
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    final client = provider.patientdata[index];
                                    return Card(
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
                                                    AppColors.primaryDarkColor,
                                                    AppColors.primaryDarkColor
                                                        .withOpacity(.5),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomCenter,
                                                  stops: const [0.0, 1.0],
                                                  tileMode: TileMode.clamp),
                                            ),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
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
                                                                child: Avatar(
                                                                    size:
                                                                        50.0)),
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
                                                                        "${client.firstName} ${client.lastName}",
                                                                    textSize:
                                                                        19,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .white10
                                                                        .withOpacity(
                                                                            .7),
                                                                    id: 1),
                                                                customText(
                                                                  text:
                                                                      "ID - #${client.id}",
                                                                  id: 1,
                                                                  textSize: 15,
                                                                  weight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                                customText(
                                                                  text:
                                                                      "Age: ${client.age}",
                                                                  id: 1,
                                                                  textSize: 15,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                              ],
                                                            ),
                                                          ]),
                                                        ],
                                                      ),
                                                    ]))));
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 4,
                                      ),
                                  itemCount: provider.patientdata.length != 0
                                      ? provider.patientdata.length
                                      : 0)))
            ],
          ),
        ),
      );
    });
  }

  addPatient(Size size, PatientsProvider patientsProvider) {
    return showGeneralDialog(
        context: context,
        barrierLabel: "Add Patient",
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
                        child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Material(
                                child: Row(
                              children: [
                                Icon(
                                  Iconsax.user_add,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                customText(
                                    textSize: 18,
                                    weight: FontWeight.bold,
                                    text: "Add New Patient",
                                    id: 1),
                              ],
                            )),
                            Divider(),
                            // SizedBox(
                            //   height: 10,
                            // ),

                            Material(
                                color: AppColors.white,
                                child: CustomTextFormField(
                                  controller: patientsProvider.fNController,
                                  hint: 'First Name',
                                )),

                            SizedBox(
                              height: 20,
                            ),
                            Material(
                                color: AppColors.white,
                                child: CustomTextFormField(
                                  controller: patientsProvider.lNController,
                                  hint: 'Last Name',
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                                color: AppColors.white,
                                child: CustomDD(
                                  isDay: false,
                                  items: _genderlist
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: SizedBox(
                                              width: size.width * 0.85,
                                              child: Text(
                                                item,
                                                style: GoogleFonts.poppins(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                                color: AppColors.white,
                                child: CustomTextFormField(
                                  controller: patientsProvider.aGController,
                                  hint: 'Age',
                                )),
                            SizedBox(height: 20),
                            Material(
                                color: AppColors.white,
                                child: CustomTextFormField(
                                  controller: patientsProvider.mobile,
                                  hint: 'Mobile',
                                )),
                            SizedBox(height: 20),
                            Material(
                                color: AppColors.white,
                                child: CustomTextFormField(
                                  controller: patientsProvider.aDController,
                                  hint: 'Address',
                                )),
                            SizedBox(height: 15),
                            Divider(),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: Container(
                                      height: 55.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: MaterialButton(
                                              onPressed: () {
                                                patientsProvider
                                                    .addPatients(
                                                        context: context,
                                                        gender: selectedValue
                                                            .toString())
                                                    .then((value) {
                                                  patientsProvider.refreshCntrlr
                                                      .requestRefresh(
                                                          needMove: false);
                                                  patientsProvider
                                                      .clearControllers();
                                                });
                                              },
                                              color: AppColors.primaryDarkColor
                                                  .withOpacity(0.8),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
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
                          ]),
                        ))));
          });
        });
  }
}
