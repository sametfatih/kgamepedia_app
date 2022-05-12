import 'package:flutter/material.dart';
import 'package:kgamepedia/models/user.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';

class GameLibraryPage extends StatelessWidget {
  final String currentUserID;
  const GameLibraryPage({Key? key, required this.currentUserID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BuildWidgets _buildWidgets = BuildWidgets();
    return SafeArea(
      child: Scaffold(
        appBar: myAppBarB(context, 'kütüphane'),
        body: SingleChildScrollView(
          child: FutureBuilder<KgameUser?>(
            future: FirebaseUserHelper.readUser(currentUserID),
            builder: (context, snapshot) =>
                _buildWidgets.buildGameWidgetCForLib(context, snapshot, currentUserID),
          ),
        ),
      ),
    );
  }
}
