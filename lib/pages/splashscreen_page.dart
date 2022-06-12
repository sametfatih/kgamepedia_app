// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:kgamepedia/pages/login_signup_page.dart';
import 'package:kgamepedia/services/sql_helper.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/routeSplashPage';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<dynamic> games = [
    'rdr_2',
    'dirt_rally_2',
    'doom_3',
    'minecraft',
    'dying_light_2',
    'gta_v',
    'forza_5',
    'csgo',
    'gow',
  ];
  List<dynamic> gameMakers = [
    'activision',
    'electronicarts',
    'mojang',
    'rockstar_games',
    'sony',
    'techland',
    'valve',
    'warnerbros',
    'xbox'
  ];
  List<dynamic> categories = [
    'fps',
    'survival',
    'open_world',
    'racing',
  ];
  @override
  void initState() {
    games.forEach((element) async => await SQLGameHelper.addGameImageUrls(element));
    gameMakers.forEach((element) async => await SQLMakerHelper.addGameMakerImageUrls(element));
    categories.forEach((element) async => await SQLCategoryHelper.addCategoryImageUrls(element));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreenView(
        navigateRoute: LoginSignUp(),
        duration: 2000,
        imageSize: 180,
        imageSrc: "assets/images/logos/kgames2.png",
        text: 'KGAMES',
        textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
