import 'package:assignment/screens/login_screen.dart';
import 'package:assignment/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SplashArt extends StatefulWidget {
  const SplashArt({super.key});

  @override
  State<SplashArt> createState() => _SplashArtState();
}

class _SplashArtState extends State<SplashArt>
    with SingleTickerProviderStateMixin {
  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (_) => const LoginScreen()));
  //   });
  // }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomizedColors.backgroundColor,
                Color.fromARGB(255, 184, 247, 252)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 288,
                  height: 288,
                ),
              ),
              Center(
                  child: Text(
                "GesT Event \nManagement System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomizedColors.fontColor,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                ),
              ))
            ],
          )),
    );
  }
}

// class SplashArt extends StatelessWidget {
//   const SplashArt({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Image(
//           image: AssetImage('assets/images/logo.jpg'),
//           width: 288,
//           height: 288,
//         ),
//       ),
//     );
//   }
// }
