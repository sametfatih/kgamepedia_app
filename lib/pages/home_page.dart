import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

class HomePage extends StatefulWidget {
  final String? currentUserID;
  const HomePage({Key? key, required this.currentUserID}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  final BuildWidgets _buildWidgets = BuildWidgets();
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarA(context, 'KGAMES'),
        body: MySingleChildScrollView(
          Axis.vertical,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Üst kısımda bulunan oyunların listelenmesi.
              SizedBox(
                height: 166.0,
                child: StreamBuilder<List<Game>>(
                  stream: _gameHelper.readGames(),
                  builder: (context, snapshot) =>
                      _buildWidgets.buildGameWidgetB(snapshot, widget.currentUserID!),
                ),
              ),
              Divider(),
              // Alt kısımda bulunan oyunların listelenmesi.
              StreamBuilder<List<Game>>(
                stream: _gameHelper.readGames(),
                builder: (context, snapshot) =>
                    _buildWidgets.buildGameWidgetA(context, snapshot, currentUserID: widget.currentUserID!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
