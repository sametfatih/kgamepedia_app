import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kgamepedia/screens/categories_screen.dart';
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
import 'package:kgamepedia/screens/home_screen.dart';
import 'package:kgamepedia/screens/login_screen.dart';
import 'package:line_icons/line_icons.dart';

import 'screens/signin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      //home: MyHomePage(),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignInPage.routeName: (context) => SignInPage(),
        CreatorPage.routeName: (context) => CreatorPage(),
        GameMakerPage.routeName: (context) => GameMakerPage(),
        MyHomePage.routeName: (context) => MyHomePage(),
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

class MyHomePage extends StatefulWidget {
  static String routeName = '/routeMyHomePage';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoriesPage(),
    //SearchPage(),
    //LikesPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 16,
                activeColor: Colors.black,
                iconSize: 26,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    icon: LineIcons.home,
                    text: 'Anasayfa',
                  ),
                  GButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    icon: LineIcons.icons,
                    text: 'Kategoriler',
                  ),

                  // GButton(
                  //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  //   icon: LineIcons.search,
                  //   text: 'Ara',
                  // ),
                  // GButton(
                  //   icon: LineIcons.heart,
                  //   text: 'Beğenilenler',
                  // ),
                  // GButton(
                  //   icon: LineIcons.user,
                  //   text: 'Profil',
                  // ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
