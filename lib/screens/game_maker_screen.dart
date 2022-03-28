import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameMakerPage extends StatefulWidget {
  static String routeName = '/routeGameMakerPage';
  final String gameMakerName;
  final String gameMakerDesc;
  final String gameMakerImage;
  const GameMakerPage({Key? key, this.gameMakerName = '', this.gameMakerDesc = '', this.gameMakerImage = ''})
      : super(key: key);

  @override
  State<GameMakerPage> createState() => _GameMakerPageState();
}

class _GameMakerPageState extends State<GameMakerPage> {
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
                        child: Text(
                          widget.gameMakerName,
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/game_maker_logos/${widget.gameMakerImage}',
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Hakkında',
                style: TextStyle(fontSize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  widget.gameMakerDesc,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
