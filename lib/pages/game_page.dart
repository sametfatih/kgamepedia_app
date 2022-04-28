import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/services/firebase_storage_helper.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/my_behavior.dart';
import 'game_maker_page.dart';

class GamePage extends StatefulWidget {
  final String gameID;
  const GamePage({Key? key, this.gameID = ''}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  FirebaseStorageHelper storageHelper = FirebaseStorageHelper();
  FirebaseGameHelper gameHelper = FirebaseGameHelper();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, 'KGAMEPEDIA'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //Oyun ekranında sol üstteki image'i getirir.
                  buildGameImage(),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: SizedBox(
                      height: 152.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: gameHelper.getGameName(widget.gameID),
                              builder: (context, snapshot) =>
                                  gameHelper.textBuild(snapshot: snapshot, fontSize: 20)),
                          SizedBox(height: 6.0),
                          FutureBuilder(
                            future: gameHelper.getGameMakerName(widget.gameID),
                            builder: (context, snapshot) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameMakerPage(
                                      gameID: widget.gameID,
                                    ),
                                  ),
                                );
                              },
                              child: gameHelper.textBuild(
                                snapshot: snapshot,
                                color: Colors.red,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Row(
                            children: [
                              Text('Platformlar: ', style: TextStyle(fontWeight: FontWeight.w500)),
                              buildPlatforms(),
                            ],
                          ),
                          buildRatingBar()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hakkında',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Flexible(
                        child: MySingleChildScrollView(
                          Axis.vertical,
                          FutureBuilder(
                              future: gameHelper.getGameDescription(widget.gameID),
                              builder: (context, snapshot) => gameHelper.textBuild(
                                  snapshot: snapshot, color: Colors.black54, fontSize: 16.0)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ekran Görüntüleri', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    MySingleChildScrollView(
                      Axis.horizontal,
                      Row(
                        children: [
                          //Oyun alttaki screenhot imagelerini getirir.
                          buildGameScreenShotImage('screenshot_1'),
                          buildGameScreenShotImage('screenshot_2'),
                          buildGameScreenShotImage('screenshot_3'),
                          buildGameScreenShotImage('screenshot_4'),
                          buildGameScreenShotImage('screenshot_5'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Oyun ekranındaki en altta bulunan satın al butonunu oluşturuluyor.
              // Görüntülenen oyuna göre veritabanından o oyunun game Link verisini çekip o linke url launcher ile yönlendirme yapılıyor.
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: FutureBuilder(
                  future: gameHelper.getGameLink(widget.gameID),
                  builder: (context, snapshot) => gameHelper.buyButtonBuild(snapshot: snapshot),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Game?> readGame() async {
    final docGame = FirebaseFirestore.instance.collection('games').doc(widget.gameID);
    final snapshot = await docGame.get();
    if (snapshot.exists) {
      return Game.fromJson(snapshot.data()!);
    }
    return null;
  }

  //Kullanıcıların verdiği puanın ortalamasını widget şeklinde getiriyor.
  Widget buildRatingBar() {
    //build edilecek ratingbar widgeti
    Widget ratingBar(List ratings) {
      double ratingAVG = 0;

      //firestore da ki ratings arrayine kullanıcının verdiği puanı ekliyor
      void unionArray(List array) {
        FirebaseFirestore.instance
            .collection('games')
            .doc(widget.gameID)
            .update({'ratings': FieldValue.arrayUnion(array)});
      }

      //ortalama rating in hesaplanması
      for (dynamic element in ratings) {
        ratingAVG = ratingAVG + element;
      }
      ratingAVG = ratingAVG / ratings.length;

      return Row(
        children: [
          Text(
            '(${ratings.length.toString()})',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: RatingBarIndicator(
              rating: ratingAVG,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.red,
              ),
              itemCount: 5,
              itemSize: 25.0,
              direction: Axis.horizontal,
            ),
          ),
          Text(ratingAVG.toStringAsFixed(1), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                List temparr = [0];
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Center(child: Text('Oyunu Puanla')),
                    content: RatingBar.builder(
                      initialRating: ratingAVG,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40,
                      itemPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      onRatingUpdate: (rating) {
                        temparr[0] = rating;
                      },
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.grey.shade300),
                            foregroundColor: MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          Navigator.pop(context, 'iptal');
                        },
                        child: Text('İptal'),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.grey.shade300),
                            foregroundColor: MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          setState(() {
                            unionArray(temparr);
                          });
                          Navigator.pop(context, 'Puanla');
                        },
                        child: Text('Puanla'),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Puan ver!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    return FutureBuilder<Game?>(
      future: readGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final game = snapshot.data;
          return ratingBar(game!.ratings);
        } else {
          return Text('Yükleniyor');
        }
      },
    );
  }

  //Platformların build edilmesi.
  Widget buildPlatforms() {
    return FutureBuilder<Game?>(
      future: readGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data == null) {
            return Text('Veri bulunamadı.');
          } else {
            if (data.platforms.length < 2) {
              return Row(
                children: [Icon(LineIcons.byName(data.platforms[0]))],
              );
            } else if (data.platforms.length < 3) {
              return Row(
                children: [
                  Icon(LineIcons.byName(data.platforms[0])),
                  Icon(LineIcons.byName(data.platforms[1])),
                ],
              );
            } else if (data.platforms.length < 4) {
              return Row(
                children: [
                  Icon(LineIcons.byName(data.platforms[0])),
                  Icon(LineIcons.byName(data.platforms[1])),
                  Icon(LineIcons.byName(data.platforms[2])),
                ],
              );
            } else {
              return Row(
                children: [
                  Icon(LineIcons.byName(data.platforms[0])),
                  Icon(LineIcons.byName(data.platforms[1])),
                  Icon(LineIcons.byName(data.platforms[2])),
                  Icon(LineIcons.byName(data.platforms[3])),
                ],
              );
            }
          }
        } else {
          return Text('Yükleniyor..');
        }
      },
    );
  }

//Oyun ekranında sol üstteki image i getirir.
  Widget buildGameImage() {
    return FutureBuilder(
        future: storageHelper.getGameImageURL(widget.gameID),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  height: 152,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  height: 152.0,
                  width: 100.0,
                  child: Center(
                    child: SizedBox(
                      height: 36.0,
                      width: 36.0,
                      child: CircularProgressIndicator(
                        color: Colors.black54,
                        strokeWidth: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

//Oyun alttaki screenhot imagelerini getirir.
  Widget buildGameScreenShotImage(String screenshotId) {
    return FutureBuilder(
        future: storageHelper.getGameScreenshotImageURL(widget.gameID, screenshotId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  height: 135,
                  width: 225,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 6.0,
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  height: 135.0,
                  width: 225.0,
                  child: Center(
                    child: SizedBox(
                      height: 36.0,
                      width: 36.0,
                      child: CircularProgressIndicator(
                        color: Colors.black54,
                        strokeWidth: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
