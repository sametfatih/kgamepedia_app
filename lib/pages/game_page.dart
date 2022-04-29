import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/pages/game_maker_page.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/services/firebase_storage_helper.dart';
import 'package:kgamepedia/services/url_launcher.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:line_icons/line_icons.dart';

class GamePage extends StatefulWidget {
  final String gameID;
  const GamePage({Key? key, this.gameID = ''}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();
  final FirebaseStorageHelper _storageHelper = FirebaseStorageHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myGameAppBar(context, 'KGAMES'),
        body: FutureBuilder<Game?>(
          future: _gameHelper.readGame(widget.gameID),
          builder: (context, snapshot) => buildGamePage(
            context,
            snapshot,
            widget.gameID,
          ),
        ),
      ),
    );
  }

  //Oyun ekranını build eder.
  Widget buildGamePage(BuildContext context, AsyncSnapshot<Game?> snapshot, String gameId) {
    Widget gamePage(Game game, Widget gameImage, Widget platforms, Widget ratingbar, Widget screenshots) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    //Oyun ekranında sol üstteki image'i getirir.
                    gameImage,
                    SizedBox(width: 8.0),
                    Expanded(
                      child: SizedBox(
                        height: 152.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Oyun ekranındaki oyun adı
                            Text(
                              game.gameName,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 6.0),
                            //Oyun ekranındaki oyun yapımcısı
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameMakerPage(
                                      gameId: game.gameId,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                game.gameMakerName,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.w500),
                              ),
                            ),

                            SizedBox(height: 6.0),
                            //Oyun ekranındaki platformlar
                            Row(
                              children: [
                                Text('Platformlar: ', style: TextStyle(fontWeight: FontWeight.w500)),
                                platforms,
                              ],
                            ),
                            //oyun ekranındaki rating bar
                            ratingbar,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //Oyun ekranındaki en altta bulunan satın al butonunu oluşturuluyor.
              // Görüntülenen oyuna göre veritabanından o oyunun game Link verisini çekip o linke url launcher ile yönlendirme yapılıyor.
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFDE15))),
                  onPressed: () {
                    launchURL(game.gameLink);
                  },
                  child: Text(
                    'Satın Al',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
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
                          Text(
                            game.gameDescription,
                            style: TextStyle(color: Colors.black54, fontSize: 16.0),
                          ),
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
                    Text(
                      'Ekran Görüntüleri',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    MySingleChildScrollView(
                      Axis.horizontal,
                      screenshots,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

    //Kullanıcıların verdiği puanın ortalamasını widget şeklinde getiriyor.
    Widget buildRatingBar() {
      //build edilecek ratingbar widgeti
      Widget ratingBar(Game game) {
        double ratingAVG = 0;

        //firestore da ki ratings arrayine kullanıcının verdiği puanı ekliyor
        Future<void> unionArray(double rating) async {
          List tempRatings = game.ratings + [rating];

          final doc = FirebaseFirestore.instance.collection('games').doc(game.gameId);
          await doc.update({'ratings': tempRatings});
        }

        //ortalama rating in hesaplanması
        for (dynamic element in game.ratings) {
          ratingAVG = ratingAVG + element;
        }
        ratingAVG = ratingAVG / game.ratings.length;

        return Row(
          children: [
            Text(
              '(${game.ratings.length.toString()})',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: RatingBarIndicator(
                rating: ratingAVG,
                itemBuilder: (context, index) => Icon(
                  LineIcons.starAlt,
                  color: Colors.red,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(ratingAVG.toStringAsFixed(1),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  double tempRating = 0;
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
                          LineIcons.starAlt,
                          color: Colors.red,
                        ),
                        onRatingUpdate: (rating) {
                          tempRating = rating;
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
                              unionArray(tempRating);
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
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ),
          ],
        );
      }

      return FutureBuilder<Game?>(
        future: _gameHelper.readGame(gameId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data;
            return ratingBar(game!);
          } else {
            return Text('Yükleniyor');
          }
        },
      );
    }

    //Platformların build edilmesi.
    Widget buildPlatforms() {
      return FutureBuilder<Game?>(
        future: _gameHelper.readGame(gameId),
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
          future: _storageHelper.getGameImageURL(gameId),
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
    Widget buildGameScreenShotImage(String gameId) {
      Widget screenshotImage(String screenshotUrl) => Padding(
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
                    screenshotUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );

      return FutureBuilder(
          future: _storageHelper.getGameScreenshotImageURLS(gameId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              final data = snapshot.data;

              return Row(
                children: [
                  screenshotImage(data[0]),
                  screenshotImage(data[1]),
                  screenshotImage(data[2]),
                  screenshotImage(data[3]),
                  screenshotImage(data[4]),
                ],
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

    if (snapshot.hasData) {
      final game = snapshot.data;
      return gamePage(
          game!, buildGameImage(), buildPlatforms(), buildRatingBar(), buildGameScreenShotImage(game.gameId));
    } else {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.black,
        ),
      );
    }
  }
}
