import 'package:flutter/material.dart';
import 'package:kgamepedia/screens/game_screens/csgo_screen.dart';
import 'package:kgamepedia/widgets/my_containers.dart';

import '../../widgets/my_appbars.dart';
import '../game_screens/back_4_blood_screen.dart';
import '../game_screens/doom_3_screen.dart';

class FpsCategorie extends StatelessWidget {
  final String categorieName = 'FPS';
  final String categorieImageName = 'fps';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, FpsCategorie().categorieName),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(18),
          childAspectRatio: (1 / 1.52),
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          crossAxisCount: 3,
          children: <Widget>[
            GameImage(context, Doom3Page.routeName, true, 'doom_3.jpg'),
            GameImage(context, CSGOPage.routeName, true, 'csgo.jpg'),
            GameImage(context, Back4BloodPage.routeName, true, 'back_4_blood.jpg'),
            GameImage(context, CSGOPage.routeName, true, 'csgo.jpg'),
            GameImage(context, Back4BloodPage.routeName, true, 'back_4_blood.jpg'),
            GameImage(context, Doom3Page.routeName, true, 'doom_3.jpg'),
          ],
        ),
      ),
    );
  }
}
