// ignore_for_file: prefer_const_constructors

import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Custom/ctext.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Provider/booking.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/tabs/tab3/tab3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  String name = "";
  String email = "";
  String mobile = "";
  CalendarView calendarView = CalendarView.day;
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

  Future<void> setProfileData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name")!;
    });
  }

  @override
  void initState() {
    super.initState();
    setProfileData();
    Future.delayed(Duration.zero, () {
      Provider.of<BookingProvider>(context, listen: false).getDashboard();
      Provider.of<BookingProvider>(context, listen: false)
          .getMonthlyAttendance(DateTime.now().month.toString(),
              DateTime.now().year.toString(), "", "")
          .then((value) {
        // datechange = DateFormat('MMMM yyy').format(DateTime.now()).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<BookingProvider>(builder: (context, provider, child) {
      return BaseWidget(
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
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: customText(
                        text: "Today's Appointments", textSize: 19, id: 1),
                  ),
                ],
              ),
              Divider(
                height: 1,
                color: AppColors.hint.withOpacity(.4),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white10),
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          text: "Total",
                          textcolor: AppColors.primaryDarkColor,
                          size: Sizes.TEXT_SIZE_24,
                          fontw: FontWeight.bold,
                        ),
                        CText(
                          text: provider.dashModel?.appointmentsToday != null
                              ? provider.dashModel!.appointmentsToday.toString()
                              : "0",
                          textcolor: AppColors.dark,
                          size: Sizes.TEXT_SIZE_24,
                          fontw: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCalendar(
                    key: ValueKey(calendarView),
                    allowedViews: const [CalendarView.day],
                    showDatePickerButton: true,
                    allowAppointmentResize: true,
                    showCurrentTimeIndicator: true,
                    showNavigationArrow: true,
                    // showTodayButton: true,
                    headerHeight: 56.0,
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
        ),
      );
    });
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
