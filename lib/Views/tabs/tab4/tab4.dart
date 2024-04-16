// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:audio_probe/Custom/avatar.dart';
import 'package:audio_probe/Custom/base_widget.dart';
import 'package:audio_probe/Custom/celevatedbutton.dart';
import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/Custom/slide_right_route.dart';
import 'package:audio_probe/Custom/texts.dart';
import 'package:audio_probe/Provider/login.provider.dart';
import 'package:audio_probe/Values/values.dart';
import 'package:audio_probe/Views/tabs/tab4/change_password.dart';
import 'package:audio_probe/components/profiletile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Tab4 extends StatefulWidget {
  const Tab4({super.key});

  @override
  State<Tab4> createState() => _Tab4State();
}

class _Tab4State extends State<Tab4> {
  String versionName = "";
  String name = "";
  String email = "";
  String mobile = "";
  String role = "";

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionName = "${packageInfo.version}-${packageInfo.buildNumber}";
    });
  }

  Future<void> setProfileData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name")!;
      mobile = sharedPreferences.getString("mobile")!;
      email = sharedPreferences.getString("email")!;
      role = sharedPreferences.getString("role")!;
    });
    print(name);
  }

  @override
  void initState() {
    super.initState();
    getPackageInfo();
    setProfileData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginUser auth = Provider.of<LoginUser>(context);
    return BaseWidget(
        child: Stack(children: [
      Container(
          color: AppColors.white,
          child: ListView(physics: ClampingScrollPhysics(), children: [
            Column(children: [
              Stack(children: [
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          AppColors.white,
                          AppColors.primaryColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
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
                              "Profile",
                              style: GoogleFonts.lato(
                                color: AppColors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Avatar(size: 64.0),
                                    SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customText(
                                              text: name,
                                              textSize: 19,
                                              weight: FontWeight.bold,
                                              id: 1),
                                          Divider(),
                                          customText(
                                            text: "#$role",
                                            id: 1,
                                            textSize: 15,
                                            weight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                          customText(
                                            text: email,
                                            id: 1,
                                            textSize: 15,
                                            weight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                          customText(
                                            text: mobile,
                                            id: 1,
                                            textSize: 15,
                                            color: AppColors.black,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    navigateto: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => UpdateProfile()));
                    },
                    icon: Iconsax.user,
                    tiletext: "Staff"),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    navigateto: () async {
                      const aboutus = "https://care4consulting.co.uk/about";
                      await canLaunchUrlString(aboutus)
                          ? launchUrlString(aboutus)
                          : print("error while opening aboutus");
                    },
                    icon: Iconsax.information,
                    tiletext: "About Us"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    navigateto: () async {
                      const terms =
                          "https://care4consulting.co.uk/terms_and_conditions.html";
                      await canLaunchUrlString(terms)
                          ? launchUrlString(terms)
                          : print("error while opening terms&condition");
                    },
                    icon: Iconsax.global,
                    tiletext: "Terms & Conditions"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    navigateto: () async {
                      const Policy =
                          "https://care4consulting.co.uk/privacy_policy.html";
                      await canLaunchUrlString(Policy)
                          ? launchUrlString(Policy)
                          : print("error while opening Policy");
                    },
                    icon: Iconsax.lock,
                    tiletext: "Privacy Policy"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    navigateto: () async {
                      Navigator.push(
                          context, SlideRightRoute(page: const ChangePwd()));
                    },
                    icon: Iconsax.verify,
                    tiletext: "Change Password"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    navigateto: () async {
                      const aboutus = "https://care4consulting.co.uk/contact";
                      await canLaunchUrlString(aboutus)
                          ? launchUrlString(aboutus)
                          : print("error while opening aboutus");
                    },
                    icon: Iconsax.call,
                    tiletext: "Contact Us"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: ProfileTile(
                    color: Colors.red,
                    navigateto: () {
                      logout(auth, context);
                    },
                    icon: Iconsax.logout,
                    tiletext: "Log Out"),
              ),
              SizedBox(height: 24.0),
              Center(child: Texts.thin("V$versionName", color: Colors.black38)),
            ])
          ])),
    ]));
  }
}

Future<void> logout(LoginUser auth, BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      context: context,
      builder: (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              color: AppColors.white10,
            ),
            height: 240,
            child: Column(
              children: [
                SizedBox(
                  height: 13,
                ),
                Container(
                  color: AppColors.white10,
                  height: 45.0,
                  width: size.width,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "Confirm Logout",
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
                          "Are you sure you want to logout?",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  color: AppColors.primaryDarkColor,
                                  fontSize: Sizes.TEXT_SIZE_22),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CElevatedButton(
                            onpressed: () {
                              auth.logout();
                            },
                            color: AppColors.primaryDarkColor,
                            size: Size(0, 50),
                            text: Text(
                              "Logout",
                              style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontSize: Sizes.TEXT_SIZE_22),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
}
