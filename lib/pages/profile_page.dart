import 'package:flutter/material.dart';
import 'package:kgamepedia/models/user.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

import '../widgets/my_appbars.dart';

class ProfilePage extends StatefulWidget {
  final String? currentUserID;
  const ProfilePage({Key? key, required this.currentUserID}) : super(key: key);

  @override
  _ProfilePAgeState createState() => _ProfilePAgeState();
}

class _ProfilePAgeState extends State<ProfilePage> {
  final BuildWidgets _buildWidgets = BuildWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarA(context, 'Profil'),
        body: Center(
          child: MySingleChildScrollView(
            Axis.vertical,
            FutureBuilder<KgameUser?>(
              future: FirebaseUserHelper.readUser(widget.currentUserID!),
              builder: (context, snapshot) => _buildWidgets.buildUser(context, snapshot),
            ),
          ),
        ));
  }
}
