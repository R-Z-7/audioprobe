// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, non_constant_identifier_names

import 'package:audio_probe/Values/dialogs.dart';
import 'package:audio_probe/Views/staff/addAppointments.dart';
import 'package:audio_probe/Views/staff/addAvailabilty.dart';
import 'package:audio_probe/Views/staff/addPatients.dart';
import 'package:audio_probe/Views/tabs/tab1/tab1.dart';
import 'package:audio_probe/Views/tabs/tab2/tab2.dart';
import 'package:audio_probe/Views/tabs/tab3/tab3.dart';
import 'package:audio_probe/Views/tabs/tab4/tab4.dart';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  final bool isStaff;
  const HomePage({
    Key? key,
    required this.isStaff,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = [
    const Tab1(key: PageStorageKey('Page1')),
    const Tab2(key: PageStorageKey('Page2')),
    const Tab3(key: PageStorageKey('Page3')),
    const Tab4(key: PageStorageKey('Page4')),
  ];
  final List<Widget> staffpages = [
    const AddAvailability(key: PageStorageKey('Page5')),
    const AddPatients(key: PageStorageKey('Page6')),
    const AddAppointments(key: PageStorageKey('Page7')),
    const Tab4(key: PageStorageKey('Page4')),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 0;
  DateTime pre_backpress = DateTime.now();
  int visit = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;
        } else {
          setState(() => _selectedIndex = 0);
          return false;
        }
      },
      child: Scaffold(
        body: PageStorage(
            bucket: bucket,
            child: widget.isStaff
                ? staffpages[_selectedIndex]
                : pages[_selectedIndex]),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: BottomBarDefault(
                borderRadius: BorderRadius.circular(8),
                top: 15,
                enableShadow: true,
                bottom: 15,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColor.withOpacity(.7),
                      blurRadius: 5)
                ],
                items: widget.isStaff ? staffIcons : items,
                backgroundColor: AppColors.primaryDarkColor,
                color: AppColors.black,
                colorSelected: Colors.white,
                titleStyle: TextStyle(color: AppColors.white, fontSize: 5),
                indexSelected: _selectedIndex,
                paddingVertical: 22,
                onTap: (int index) => setState(() => _selectedIndex = index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar ----
  List<TabItem> items = [
    TabItem(icon: Iconsax.home),
    TabItem(
      icon: Iconsax.people,
    ),
    TabItem(
      icon: Iconsax.calendar,
    ),
    TabItem(icon: Iconsax.user)
  ];

  List<TabItem> staffIcons = [
    TabItem(icon: Iconsax.activity),
    TabItem(
      icon: Iconsax.people,
    ),
    TabItem(
      icon: Iconsax.calendar_add,
    ),
    TabItem(icon: Iconsax.user)
  ];
}
