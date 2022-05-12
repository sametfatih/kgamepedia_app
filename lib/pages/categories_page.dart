import 'package:flutter/material.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

import '../models/category.dart';
import '../widgets/my_appbars.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _ProfilePAgeState createState() => _ProfilePAgeState();
}

class _ProfilePAgeState extends State<CategoriesPage> {
  final FirebaseCategoryHelper _categoryHelper = FirebaseCategoryHelper();
  final BuildWidgets _buildWidgets = BuildWidgets();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarA(context, 'Kategoriler'),
        body: MySingleChildScrollView(
          Axis.vertical,
          StreamBuilder<List<Categories?>>(
            stream: _categoryHelper.readCategories(),
            builder: (context, snapshot) {
              return _buildWidgets.buildCategories(context, snapshot);
            },
          ),
        ),
      ),
    );
  }
}
