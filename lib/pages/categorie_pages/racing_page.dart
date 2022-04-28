import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

class RacingCategory extends StatefulWidget {
  static String categorieName = 'yarış';
  RacingCategory({Key? key}) : super(key: key);

  @override
  State<RacingCategory> createState() => _RacingCategoryState();
}

class _RacingCategoryState extends State<RacingCategory> {
  final FirebaseCategoryHelper _categoryHelper = FirebaseCategoryHelper();
  final BuildWidgets _buildWidgets = BuildWidgets();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, RacingCategory.categorieName),
        body: MySingleChildScrollView(
          Axis.vertical,
          StreamBuilder<List<Game?>>(
            stream: _categoryHelper.readGamesForCategory(RacingCategory.categorieName),
            builder: (context, snapshot) => _buildWidgets.buildGameWidgetC(context, snapshot),
          ),
        ),
      ),
    );
  }
}
