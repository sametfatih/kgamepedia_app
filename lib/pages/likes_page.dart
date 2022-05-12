import 'package:flutter/material.dart';
import 'package:kgamepedia/models/user.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';

import '../services/firebase_firestore_helper.dart';
import '../widgets/my_appbars.dart';

class LikesPage extends StatefulWidget {
  final String? currentUserID;
  const LikesPage({Key? key, required this.currentUserID}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  final BuildWidgets __buildWidgets = BuildWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: myAppBarA(context, 'Beğenilenler'),
      body: FutureBuilder<KgameUser?>(
        future: FirebaseUserHelper.readUser(widget.currentUserID!),
        builder: (context, snapshot) =>
            __buildWidgets.buildGameWidgetAForLikes(context, snapshot, widget.currentUserID!),
      ),
    );
  }
}
