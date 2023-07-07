// import 'package:cashmate/intro/firstscreen.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     gotoHome();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: Text(
//             "CASHMATE",
//             style: TextStyle(
//                 color: Color(0xFF77C170),
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> gotoHome() async {
//     await Future.delayed(const Duration(seconds: 3));
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) =>  const FirstScreen(),
//     ));
//   }
// }

import 'package:cashmate/intro/firstscreen.dart';
import 'package:cashmate/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        'photos/Logo_Image.png',
        height: 300,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    Future.delayed(
      const Duration(seconds: 4),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const FirstScreen()),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final sharedpref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedpref.getBool(saveKeyName);
    if (userLoggedIn == null || userLoggedIn == false) {
      gotoLogin();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => BottomBar()));
    }
  }
}
