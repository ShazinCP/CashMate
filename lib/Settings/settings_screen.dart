// import 'package:cashmate/Settings/about.dart';
// import 'package:cashmate/Settings/privacy_policy.dart';
// import 'package:cashmate/Settings/settingsfunctions.dart';
// import 'package:cashmate/Settings/terms_and_conditions.dart';
// import 'package:flutter/material.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xff368983),
//           title: const Center(
//             child: Text(
//               "Settings",
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // Navigator.of(context).push(
//                         //     MaterialPageRoute(builder: (context) => const YourAccount()));
//                       },
//                       child: const ListTile(
//                         leading: Image(image: AssetImage("assets/limit.png")),
//                         title: Text("Change Limit",
//                             style: TextStyle(fontSize: 22, color: Colors.black)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) => const About()));
//                       },
//                       child: const ListTile(
//                         leading: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Image(image: AssetImage("assets/about.png"),height: 45,),
//                         ),
//                         title: Text("About",
//                             style: TextStyle(fontSize: 22, color: Colors.black)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // Navigator.of(context).push(
//                         //     MaterialPageRoute(builder: (context) => const YourAccount()));
//                       },
//                       child: const ListTile(
//                         leading: Icon(
//                           Icons.refresh_outlined,
//                           size: 42,
//                           color: Colors.black,
//                         ),
//                         title: Text("Reset",
//                             style: TextStyle(fontSize: 22, color: Colors.black)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // Navigator.of(context).push(
//                         //     MaterialPageRoute(builder: (context) => const YourAccount()));
//                       },
//                       child: const ListTile(
//                         leading: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Image(
//                             image: AssetImage("assets/share.png"),
//                             height: 50,
//                           ),
//                         ),
//                         title: Text("Share",
//                             style: TextStyle(fontSize: 22, color: Colors.black)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) =>  const Terms()));
//                       },
//                       child: const ListTile(
//                         leading: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Image(
//                               image:
//                                   AssetImage("assets/terms_and_conditions.png")),
//                         ),
//                         title: Text("Terms & Conditions",
//                             style: TextStyle(fontSize: 22, color: Colors.black)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
//                       },
//                       child: const ListTile(
//                         leading: Image(
//                           image: AssetImage("assets/privacy.png"),
//                           height: 40,
//                           width: 40,
//                         ),
//                         title: Text("Privacy Policy",
//                             style: TextStyle(fontSize: 22, color: Colors.black)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cashmate/Settings/about.dart';
import 'package:cashmate/Settings/privacy_policy.dart';
import 'package:cashmate/Settings/settingsfunctions.dart';
import 'package:cashmate/Settings/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

TextEditingController limitchangecontroller = TextEditingController();

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
          backgroundColor: const Color(0xff368983),
          title: const Center(
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
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
                        backgroundColor: Colors.red,
                        //duration: Duration.th,
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    SettingFunctions().editLimit(context);
                  }

                  //SettingFunctions().editLimit(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Change Limit',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          //19,
                          color: const Color.fromARGB(255, 11, 11, 11)),
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
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  SettingFunctions().resetApp(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.restore,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Reset',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
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
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
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
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Terms&Conditions',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
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
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
