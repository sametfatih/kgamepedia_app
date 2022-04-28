import 'package:flutter/material.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/services/firebase_storage_helper.dart';

class GameMakerPage extends StatefulWidget {
  final String gameID;
  final String makerID;
  const GameMakerPage({Key? key, this.makerID = '', this.gameID = ''}) : super(key: key);

  @override
  State<GameMakerPage> createState() => _GameMakerPageState();
}

class _GameMakerPageState extends State<GameMakerPage> {
  FirebaseGameHelper gameHelper = FirebaseGameHelper();
  FirebaseStorageHelper storageHelper = FirebaseStorageHelper();
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
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FutureBuilder(
                          future: gameHelper.getGameMakerName(widget.gameID),
                          builder: (context, snapshot) {
                            return gameHelper.textBuild(snapshot: snapshot, fontSize: 24);
                          },
                        ),
                      ),
                    ),
                    buildMakerImage(),
                  ],
                ),
              ),
              Text(
                'Hakkında',
                style: TextStyle(fontSize: 18.0),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: FutureBuilder(
                    future: gameHelper.getGameMakerDesc(widget.gameID),
                    builder: (context, snapshot) => gameHelper.textBuild(snapshot: snapshot),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //Game Maker sayfasında ki logoyu build ediyor.
  Widget buildMakerImage() {
    return FutureBuilder(
      future: storageHelper.getGameMakerImageURL(widget.gameID),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            flex: 2,
            child: Image.network(snapshot.data!.toString(), fit: BoxFit.fill),
          );
        } else {
          return Flexible(
            flex: 2,
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            ),
          );
        }
      },
    );
  }
}
