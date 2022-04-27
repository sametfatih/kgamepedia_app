import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
        appBar: myAppBar(context, 'KGAMEPEDIA'),
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
                  builder: (context, snapshot) => _buildWidgets.buildGameWidgetB(snapshot),
                ),
              ),
              Divider(),
              // Alt kısımda bulunan oyunların listelenmesi.
              StreamBuilder<List<Game>>(
                stream: _gameHelper.readGames(),
                builder: (context, snapshot) => _buildWidgets.buildGameWidgetA(context, snapshot),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
