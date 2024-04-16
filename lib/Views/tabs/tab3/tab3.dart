// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Provider/booking.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Tab3 extends StatefulWidget {
  const Tab3({super.key});

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
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
  bool isToggled = false;
  void weekday(DateTime currentDate) {
    var currentWeekday = currentDate.weekday;
    var offset = currentWeekday - DateTime.sunday;
    if (offset < 0) {
      offset = 7 + offset;
    }
    var sunday = currentDate.subtract(Duration(days: offset));
    var saturday = sunday.add(Duration(days: 6));
    startday = DateFormat('dd MMMM').format(sunday);
    endday = DateFormat('dd MMMM').format(saturday);
    startday4 = DateFormat("yyyy-MM-dd").format(sunday);
    endday4 = DateFormat("yyyy-MM-dd").format(saturday);
    if (kDebugMode) {
      print('Start of the week: $startday' + ', End of the week: $endday');
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       onTap: () {

                  //       },
                  //       child: CircleAvatar(
                  //         radius: 30,
                  //         backgroundColor: AppColors.white,
                  //         child: CircleAvatar(
                  //             radius: 27,
                  //             backgroundColor: AppColors.primaryDarkColor,
                  //             child: Icon(Iconsax.calendar_search)),
                  //       ),
                  //     ),
                  //   ],
                  // )
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
                          _year != "" ? _year : DateTime.now().year.toString(),
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
                    allowedViews: const [CalendarView.month, CalendarView.week],
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

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
