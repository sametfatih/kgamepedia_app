import 'package:flutter/material.dart';
import 'package:kgamepedia/screens/categorie_screens/fps_screen.dart';
import 'package:kgamepedia/screens/categorie_screens/racing_screen.dart';
import 'package:kgamepedia/screens/categorie_screens/survival_screen.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:kgamepedia/widgets/my_containers.dart';

import '../widgets/my_appbars.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _ProfilePAgeState createState() => _ProfilePAgeState();
}

class _ProfilePAgeState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(context, 'Kategoriler'),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Categories(
                  context,
                  SurvivalCategorie(),
                  SurvivalCategorie().categorieName,
                  SurvivalCategorie().categorieImageName,
                ),
                Categories(
                  context,
                  FpsCategorie(),
                  FpsCategorie().categorieName,
                  FpsCategorie().categorieImageName,
                ),
                Categories(
                  context,
                  RacingCategorie(),
                  RacingCategorie().categorieName,
                  RacingCategorie().categorieImageName,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
