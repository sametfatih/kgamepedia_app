import 'package:flutter/material.dart';
import 'package:kgamepedia/screens/game_screens/dying_light2_screen.dart';

import '../../widgets/my_appbars.dart';
import '../../widgets/my_containers.dart';
import '../game_screens/minecraft_screen.dart';

class SurvivalCategorie extends StatelessWidget {
  final String categorieName = 'HAYATTA KALMA';
  final String categorieImageName = 'survival';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, SurvivalCategorie().categorieName),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
