import 'package:flutter/material.dart';
import 'package:kgamepedia/pages/login_signup_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/routeSplashPage';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginSignUp(),
      duration: 3000,
      imageSize: 180,
      imageSrc: "assets/images/logos/kgames2.png",
      text: 'KGAMES',
      textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
    );
  }
}
