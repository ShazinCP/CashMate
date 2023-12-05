import 'package:cashmate/constants/sizedbox.dart';
import 'package:cashmate/controller/settings_provider.dart';
import 'package:cashmate/helper/colors.dart';
import 'package:cashmate/views/settings/widgets/about.dart';
import 'package:cashmate/views/settings/widgets/privacy_policy.dart';
import 'package:cashmate/views/settings/widgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double textSize = size.width * 0.05;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cAppThemeColor,
          title: const Center(
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.getString("limit") == null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Oops..!!!  Please Set Limit in Home Page",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17),
                          ),
                          backgroundColor: cRedColor,
                          //duration: Duration.th,
                        ),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      provider.editLimit(context);
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        size: 30,
                      ),
                    cWidth30,
                      Text(
                        'Change Limit',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: cBlackARGBColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const About()));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 30,
                      ),
                      cWidth30,
                      Text(
                        'About',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: cBlackARGBColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    provider.resetApp(context);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.restore,
                        size: 30,
                      ),
                     cWidth30,
                      Text(
                        'Reset',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: cBlackARGBColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(
                        'Hey! check out this new app......https://play.google.com/store/apps/details?id=in.brototype.spendee');
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.share,
                        size: 30,
                      ),
                    cWidth30,
                      Text(
                        'Share',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: cBlackARGBColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Terms()));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.document_scanner_outlined,
                        size: 30,
                      ),
                     cWidth30,
                      Text(
                        'Terms&Conditions',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: cBlackARGBColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy()));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.privacy_tip_outlined,
                        size: 30,
                      ),
                    cWidth30,
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: cBlackARGBColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
            },
             
          ),
        ),
      ),
    );
  }
}
