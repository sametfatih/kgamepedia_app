import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgamepedia/screens/creator_screen.dart';
import 'package:kgamepedia/screens/game_maker_screen.dart';
import 'package:kgamepedia/screens/game_screens/back_4_blood_screen.dart';
import 'package:kgamepedia/screens/game_screens/csgo_screen.dart';
import 'package:kgamepedia/screens/game_screens/dirt_rally_screen.dart';
import 'package:kgamepedia/screens/game_screens/doom_3_screen.dart';
import 'package:kgamepedia/screens/game_screens/dying_light2_screen.dart';
import 'package:kgamepedia/screens/game_screens/forza5_screen.dart';
import 'package:kgamepedia/screens/game_screens/gow_screen.dart';
import 'package:kgamepedia/screens/game_screens/gta_v_screen.dart';
import 'package:kgamepedia/screens/game_screens/minecraft_screen.dart';
import 'package:kgamepedia/screens/login_screen.dart';
import 'package:kgamepedia/widgets/navigation_bar.dart';

import 'screens/signin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignInPage.routeName: (context) => SignInPage(),
        CreatorPage.routeName: (context) => CreatorPage(),
        GameMakerPage.routeName: (context) => GameMakerPage(),
        GNavBar.routeName: (context) => GNavBar(),
        DyigLight2Page.routeName: (context) => DyigLight2Page(),
        CSGOPage.routeName: (context) => CSGOPage(),
        GOWPage.routeName: (context) => GOWPage(),
        GtaVPage.routeName: (context) => GtaVPage(),
        MinecraftPage.routeName: (context) => MinecraftPage(),
        Doom3Page.routeName: (context) => Doom3Page(),
        Back4BloodPage.routeName: (context) => Back4BloodPage(),
        Forza5Page.routeName: (context) => Forza5Page(),
        DirtRallyPage.routeName: (context) => DirtRallyPage(),
      },
    );
  }
}
