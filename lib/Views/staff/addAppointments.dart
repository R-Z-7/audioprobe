// ignore_for_file: prefer_const_constructors

import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/systempadding.dart';
import 'package:audio_probe/Models/clients.model.dart';
import 'package:audio_probe/Provider/booking.provider.dart';
import 'package:audio_probe/Provider/clients.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/tabs/tab3/tab3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddAppointments extends StatefulWidget {
  const AddAppointments({super.key});

  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {
  CalendarView calendarView = CalendarView.month;
  String datechange = '';
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
  String _month = "";
  String _year = "";
  var startday;
  var startday2;
  var startday3;
  var startday4;
  var endday;
  var endday2;
  var endday3;
  var endday4;
  DateTime selectedDate = DateTime.now();
  var selectedPatientId = "";
  bool isToggled = false;
  void weekday(DateTime currentDate) {
    var currentWeekday = currentDate.weekday;
    var offset = currentWeekday - DateTime.sunday;
    if (offset < 0) {
      offset = 7 + offset;
    }
    var sunday = currentDate.subtract(Duration(days: offset));
    var saturday = sunday.add(const Duration(days: 6));
    startday = DateFormat('dd MMMM').format(sunday);
    endday = DateFormat('dd MMMM').format(saturday);
    startday4 = DateFormat("yyyy-MM-dd").format(sunday);
    endday4 = DateFormat("yyyy-MM-dd").format(saturday);
    if (kDebugMode) {
      print('Start of the week: $startday' + ', End of the week: $endday');
    }
  }

  final RefreshController refreshCntrlr3 =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
    weekday(DateTime.now());
    Future.delayed(Duration.zero, () {
      Provider.of<BookingProvider>(context, listen: false)
          .getMonthlyAttendance(DateTime.now().month.toString(),
              DateTime.now().year.toString(), "", "")
          .then((value) {
        datechange = DateFormat('MMMM yyy').format(DateTime.now()).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<BookingProvider>(builder: (context, provider, child) {
      return BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addAppointments(size, provider);
          },
          backgroundColor: AppColors.primaryDarkColor,
          child: const Icon(
            Iconsax.note_add,
            color: AppColors.white,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  // const SizedBox(height: 25),
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
                        "Appointments",
                        style: GoogleFonts.lato(
                          color: AppColors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ToggleSwitch(
                    minWidth: size.width,
                    customTextStyles: const [
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)
                    ],
                    cornerRadius: 8.0,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: isToggled ? 1 : 0,
                    // changeOnTap: true,
                    totalSwitches: 2,
                    activeBgColor: [
                      AppColors.primaryDarkColor,
                      AppColors.primaryColor
                    ],
                    labels: const ['Monthly', 'Weekly'],
                    onToggle: (index) {
                      print('switched to: $index');
                      setState(() {
                        if (index == 1) {
                          startday2 != null
                              ? provider.getMonthlyAttendance(
                                  "", "", startday2, endday2)
                              : provider.getMonthlyAttendance(
                                  "", "", startday4, endday4);
                          calendarView = CalendarView.week;
                          datechange = startday2 != null
                              ? '$startday3 - $endday3'
                              : '$startday - $endday';
                        } else {
                          provider.getMonthlyAttendance(
                              _month != ""
                                  ? _month
                                  : DateTime.now().month.toString(),
                              _year != ""
                                  ? _year
                                  : DateTime.now().year.toString(),
                              "",
                              "");
                          calendarView = CalendarView.month;
                          datechange = DateFormat('MMMM yyy')
                              .format(DateTime.now())
                              .toString();
                        }
                        isToggled = index == 1;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width + 56,
                      child: SfCalendar(
                        key: ValueKey(calendarView),
                        allowedViews: const [
                          CalendarView.month,
                          CalendarView.week
                        ],
                        showDatePickerButton: true,
                        allowAppointmentResize: true,
                        showCurrentTimeIndicator: true,
                        showNavigationArrow: true,
                        // showTodayButton: true,
                        headerHeight: 56.0,
                        onViewChanged: (viewChangedDetails) {
                          if (calendarView == CalendarView.month) {
                            viewChanged(viewChangedDetails, provider, true);
                          } else if (calendarView == CalendarView.week) {
                            viewChanged(viewChangedDetails, provider, false);
                          }
                        },
                        monthViewSettings: const MonthViewSettings(
                          appointmentDisplayMode:
                              MonthAppointmentDisplayMode.indicator,
                          showAgenda: false,
                          agendaItemHeight: 40.0,
                          agendaViewHeight: 56.0,
                        ),
                        dataSource: MeetingDataSource(provider.meetings),
                        view: calendarView,
                        backgroundColor: Colors.white,
                        todayHighlightColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Future addAppointments(Size size, BookingProvider bookingProvider) {
    PatientsProvider patientsProvider =
        Provider.of<PatientsProvider>(context, listen: false);
    patientsProvider.getlistofPatients(context: context);
    return showGeneralDialog(
        context: context,
        barrierLabel: "Add Appointments",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (filtercontext, __, ___) {
          patientsProvider.getlistofPatients(context: context);
          return StatefulBuilder(builder: (context, setState) {
            return SystemPadding(
                child: Center(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Material(
                              child: Row(
                            children: [
                              Icon(
                                Iconsax.calendar_add,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const customText(
                                  textSize: 18,
                                  weight: FontWeight.bold,
                                  text: "Schedule Appointments",
                                  id: 1),
                            ],
                          )),
                          const Divider(),
                          Material(
                            color: AppColors.white,
                            child: TextFormField(
                              readOnly: true,
                              controller: bookingProvider.controllerdate,
                              keyboardType: TextInputType.number,
                              onTap: () =>
                                  _selectdate(context, bookingProvider),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                labelText: 'Date',
                                labelStyle: TextStyle(fontSize: 16.0),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            color: AppColors.white,
                            child: TextFormField(
                              controller: patientsProvider.patientSearch,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                labelText: 'Patient',
                                labelStyle: TextStyle(fontSize: 16.0),
                                border: OutlineInputBorder(),
                                suffixIcon: DropdownButton<Datum>(
                                  items: patientsProvider.patientdata
                                      .map((patient) => DropdownMenuItem(
                                            value: patient,
                                            child: Text(patient.firstName! +
                                                patient.lastName!),
                                          ))
                                      .toList(),
                                  onChanged: (selectedPatient) {
                                    selectedPatientId =
                                        selectedPatient!.id!.toString();
                                    setState(
                                      () {
                                        patientsProvider.patientSearch.text =
                                            selectedPatient.firstName! +
                                                selectedPatient.firstName!;
                                      },
                                    );

                                    // Do something with the selected ID
                                  },
                                ),
                              ),
                            ),
                          )
                          // Material(
                          //   color: AppColors.white,
                          //   child: TextFormField(
                          //     controller: bookingProvider.slotcontroller,
                          //     keyboardType: TextInputType.number,
                          //     decoration: const InputDecoration(
                          //       contentPadding:
                          //           EdgeInsets.symmetric(horizontal: 16.0),
                          //       labelText: 'Clients',
                          //       labelStyle: TextStyle(fontSize: 16.0),
                          //       border: OutlineInputBorder(),
                          //     ),
                          //   ),
                          // ),
                          ,
                          const SizedBox(
                            height: 16.0,
                          ),
                          const SizedBox(height: 15),
                          const Divider(),
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
                                        patientsProvider.clearControllers();
                                      },
                                      color: AppColors.primaryDarkColor
                                          .withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: const Center(
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
                                              bookingProvider
                                                  .addAppointments(
                                                      context: context,
                                                      bookingTime: selectedDate
                                                          .toString(),
                                                      clientId:
                                                          selectedPatientId)
                                                  .then((value) {
                                                bookingProvider
                                                    .clearControllers();
                                                patientsProvider
                                                    .clearControllers();
                                              });
                                            },
                                            color: AppColors.primaryDarkColor
                                                .withOpacity(0.8),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: const Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
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

  void viewChanged(ViewChangedDetails viewChangedDetails,
      BookingProvider bookingProvider, bool month) {
    if (month) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        setState(() {
          _month = DateFormat('M')
              .format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
          _year = DateFormat('yyyy')
              .format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
          datechange = DateFormat('MMMM yyy')
              .format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
        });
        bookingProvider.getMonthlyAttendance(_month, _year, "", "");
        print(_month);
        print(_year);
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        var currentWeekday = viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2].weekday;
        var offset = currentWeekday - DateTime.sunday;
        if (offset < 0) {
          offset = 7 + offset;
        }
        var sunday = viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]
            .subtract(Duration(days: offset));
        var saturday = sunday.add(const Duration(days: 6));
        setState(() {
          startday2 = DateFormat("yyyy-MM-dd").format(sunday);
          endday2 = DateFormat("yyyy-MM-dd").format(saturday);
          startday3 = DateFormat('dd MMMM').format(sunday);
          endday3 = DateFormat('dd MMMM').format(saturday);
          datechange = '$startday3 - $endday3';
        });
        bookingProvider.getMonthlyAttendance("", "", startday2, endday2);
        print(startday2);
        print(endday2);
      });
    }
  }
}
