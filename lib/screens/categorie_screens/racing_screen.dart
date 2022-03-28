import 'package:flutter/material.dart';
import 'package:kgamepedia/screens/game_screens/forza5_screen.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

import '../../widgets/my_appbars.dart';
import '../../widgets/my_containers.dart';
import '../game_screens/dirt_rally_screen.dart';

class RacingCategorie extends StatelessWidget {
  final String categorieName = 'YARIŞ';
  final String categorieImageName = 'racing';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, RacingCategorie().categorieName),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GameImageAndName2(
                  context,
                  Forza5Page.routeName,
                  GameImage(context, Forza5Page.routeName, true, 'forza5.jpg'),
                  'Forza Horizon 5',
                  'forza5_screenshot_5',
                  Forza5Page().rating,
                  Forza5Page().ratingCounter,
                  Forza5Page().platforms,
                ),
                GameImageAndName2(
                  context,
                  DirtRallyPage.routeName,
                  GameImage(context, DirtRallyPage.routeName, true, 'dirt_rally.jpg'),
                  'Dirt Rally 2.0',
                  'dirt_rally_screenshot_2',
                  Forza5Page().rating,
                  Forza5Page().ratingCounter,
                  Forza5Page().platforms,
                ),
                GameImageAndName2(
                  context,
                  Forza5Page.routeName,
                  GameImage(context, Forza5Page.routeName, true, 'forza5.jpg'),
                  'Forza Horizon 5',
                  'forza5_screenshot_5',
                  Forza5Page().rating,
                  Forza5Page().ratingCounter,
                  Forza5Page().platforms,
                ),
                GameImageAndName2(
                  context,
                  DirtRallyPage.routeName,
                  GameImage(context, DirtRallyPage.routeName, true, 'dirt_rally.jpg'),
                  'Dirt Rally 2.0',
                  'dirt_rally_screenshot_2',
                  Forza5Page().rating,
                  Forza5Page().ratingCounter,
                  Forza5Page().platforms,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
