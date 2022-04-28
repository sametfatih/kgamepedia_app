import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';

class GameMakerPage extends StatefulWidget {
  final String gameId;
  const GameMakerPage({Key? key, this.gameId = ''}) : super(key: key);

  @override
  State<GameMakerPage> createState() => _GameMakerPageState();
}

class _GameMakerPageState extends State<GameMakerPage> {
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();
  final BuildWidgets _buildWidgets = BuildWidgets();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: FutureBuilder<Game?>(
              future: _gameHelper.readGame(widget.gameId),
              builder: (context, snapshot) => _buildWidgets.buildGameMakerPage(snapshot))),
    );
  }
}
