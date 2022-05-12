import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgamepedia/pages/categorie_pages/fps_page.dart';
import 'package:kgamepedia/pages/categorie_pages/open_world_page.dart';
import 'package:kgamepedia/pages/categorie_pages/racing_page.dart';
import 'package:kgamepedia/pages/categorie_pages/survival_page.dart';
import 'package:kgamepedia/pages/creator_page.dart';
import 'package:kgamepedia/pages/login_page.dart';
import 'package:kgamepedia/pages/login_signup_page.dart';
import 'package:kgamepedia/pages/splashscreen_page.dart';
import 'package:kgamepedia/services/user_preferences.dart';
import 'package:kgamepedia/utils/config/themes.dart';

import 'pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Kgames());
}

class Kgames extends StatelessWidget {
  Kgames({Key? key}) : super(key: key);
  final String? theme = UserPreferences.getTheme() ?? 'red';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme == 'red' ? redTheme : tealTheme,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        LoginSignUp.routeName: (context) => LoginSignUp(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        CreatorPage.routeName: (context) => CreatorPage(),
        '/${FpsCategory.categorieName}': (context) => FpsCategory(),
        '/${RacingCategory.categorieName}': (context) => RacingCategory(),
        '/${SurvivalCategory.categorieName}': (context) => SurvivalCategory(),
        '/${OpenWorldCategory.categorieName}': (context) => OpenWorldCategory(),
      },
    );
  }
}
