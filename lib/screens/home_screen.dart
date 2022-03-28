import 'package:flutter/material.dart';
import 'package:kgamepedia/screens/game_screens/back_4_blood_screen.dart';
import 'package:kgamepedia/screens/game_screens/csgo_screen.dart';
import 'package:kgamepedia/screens/game_screens/dirt_rally_screen.dart';
import 'package:kgamepedia/screens/game_screens/doom_3_screen.dart';
import 'package:kgamepedia/screens/game_screens/gow_screen.dart';
import 'package:kgamepedia/screens/game_screens/gta_v_screen.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:kgamepedia/widgets/my_containers.dart';

import '../widgets/my_appbars.dart';
import 'game_screens/dying_light2_screen.dart';
import 'game_screens/forza5_screen.dart';
import 'game_screens/minecraft_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context, 'KGAMEPEDIA'),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GameImage(context, Forza5Page.routeName, true, 'forza5.jpg'),
                      GameImage(context, GtaVPage.routeName, true, 'gtav.jpg'),
                      GameImage(context, DyigLight2Page.routeName, true, 'dyinglight2.jpg'),
                      GameImage(context, CSGOPage.routeName, true, 'csgo.jpg'),
                      GameImage(context, DirtRallyPage.routeName, true, 'dirt_rally.jpg'),
                      GameImage(context, Doom3Page.routeName, true, 'doom_3.jpg'),
                      GameImage(context, Back4BloodPage.routeName, true, 'back_4_blood.jpg'),
                      GameImage(context, GOWPage.routeName, true, 'gow.jpg'),
                      GameImage(context, MinecraftPage.routeName, true, 'minecraft.jpg'),
                    ],
                  ),
                ),
                Container(height: 0.05, width: double.infinity, color: Colors.black),
                GameImageAndName(
                  context,
                  MinecraftPage.routeName,
                  GameImage(context, MinecraftPage.routeName, true, 'minecraft.jpg'),
                  'Minecraft',
                  'minecraft_screenshot_1',
                  MinecraftPage().rating,
                  MinecraftPage().ratingCounter,
                  MinecraftPage().platforms,
                  'Mojang',
                ),
                GameImageAndName(
                  context,
                  DyigLight2Page.routeName,
                  GameImage(context, DyigLight2Page.routeName, true, 'dyinglight2.jpg'),
                  'Dying Light 2',
                  'dyinglight2_1',
                  DyigLight2Page().rating,
                  DyigLight2Page().ratingCounter,
                  DyigLight2Page().platforms,
                  'Techland',
                ),
                GameImageAndName(
                  context,
                  Forza5Page.routeName,
                  GameImage(context, Forza5Page.routeName, true, 'forza5.jpg'),
                  'Forza  Horizon 5',
                  'forza5_screenshot_1',
                  Forza5Page().rating,
                  Forza5Page().ratingCounter,
                  Forza5Page().platforms,
                  'Xbox Game Studios',
                ),
                GameImageAndName(
                  context,
                  DirtRallyPage.routeName,
                  GameImage(context, DirtRallyPage.routeName, true, 'dirt_rally.jpg'),
                  'Dirt Rally 2.0',
                  'dirt_rally_screenshot_1',
                  DirtRallyPage().rating,
                  DirtRallyPage().ratingCounter,
                  DirtRallyPage().platforms,
                  'Electronic Arts',
                ),
                GameImageAndName(
                    context,
                    GtaVPage.routeName,
                    GameImage(context, GtaVPage.routeName, true, 'gtav.jpg'),
                    'GTA V',
                    'gtav_screenshot_1',
                    GtaVPage().rating,
                    GtaVPage().ratingCounter,
                    GtaVPage().platforms,
                    'Rockstar Games'),
                GameImageAndName(
                  context,
                  CSGOPage.routeName,
                  GameImage(context, CSGOPage.routeName, true, 'csgo.jpg'),
                  'Counter Strike Global Offensive',
                  'csgo_screenshot_1',
                  CSGOPage().rating,
                  CSGOPage().ratingCounter,
                  CSGOPage().platforms,
                  'Valve',
                ),
                GameImageAndName(
                  context,
                  GOWPage.routeName,
                  GameImage(context, GOWPage.routeName, true, 'gow.jpg'),
                  'God Of War',
                  'gow_screenshot_1',
                  GOWPage().rating,
                  GOWPage().ratingCounter,
                  GOWPage().platforms,
                  'Sony',
                ),
                GameImageAndName(
                  context,
                  Doom3Page.routeName,
                  GameImage(context, Doom3Page.routeName, true, 'doom_3.jpg'),
                  'DOOM 3',
                  'doom_3_screenshot_1',
                  Doom3Page().rating,
                  Doom3Page().ratingCounter,
                  Doom3Page().platforms,
                  'Activision',
                ),
                GameImageAndName(
                  context,
                  Back4BloodPage.routeName,
                  GameImage(context, Back4BloodPage.routeName, true, 'back_4_blood.jpg'),
                  'Back 4 Blood',
                  'back_4_blood_screenshot_1',
                  Back4BloodPage().rating,
                  Back4BloodPage().ratingCounter,
                  Back4BloodPage().platforms,
                  'Warner Bros.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
