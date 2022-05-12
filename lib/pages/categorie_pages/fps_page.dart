import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';

import '../../services/firebase_firestore_helper.dart';
import '../../widgets/my_appbars.dart';

class FpsCategory extends StatefulWidget {
  static String categorieName = 'fps';
  FpsCategory({Key? key}) : super(key: key);

  @override
  State<FpsCategory> createState() => _FpsCategoryState();
}

class _FpsCategoryState extends State<FpsCategory> {
  final FirebaseCategoryHelper _categoryHelper = FirebaseCategoryHelper();
  final BuildWidgets _buildWidgets = BuildWidgets();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarB(context, FpsCategory.categorieName),
        body: StreamBuilder<List<Game?>>(
          stream: _categoryHelper.readGamesForCategory(FpsCategory.categorieName),
          builder: (context, snapshot) => _buildWidgets.buildGameWidgetBForFps(snapshot),
        ),
      ),
    );
  }
}
