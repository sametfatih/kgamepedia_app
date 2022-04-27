import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

class SurvivalCategory extends StatefulWidget {
  static String categorieName = 'hayatta kalma';

  const SurvivalCategory({Key? key}) : super(key: key);

  @override
  State<SurvivalCategory> createState() => _SurvivalCategoryState();
}

class _SurvivalCategoryState extends State<SurvivalCategory> {
  final FirebaseCategoryHelper _categoryHelper = FirebaseCategoryHelper();
  final BuildWidgets _buildWidgets = BuildWidgets();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, SurvivalCategory.categorieName),
        body: MySingleChildScrollView(
          Axis.vertical,
          StreamBuilder<List<Game?>>(
            stream: _categoryHelper.readGamesForCategory(SurvivalCategory.categorieName),
            builder: (context, snapshot) => _buildWidgets.buildGameWidgetA(context, snapshot),
          ),
        ),
      ),
    );
  }
}
