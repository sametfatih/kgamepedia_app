import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kgamepedia/pages/profile_pages/charts_page.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:line_icons/line_icons.dart';

import '../models/category.dart';
import '../models/game.dart';
import '../models/user.dart';
import '../models/weather.dart';
import '../pages/game_page.dart';
import '../pages/profile_pages/game_library_page.dart';
import '../pages/profile_pages/settings_page.dart';
import '../pages/profile_pages/user_information_page.dart';
import '../services/firebase_firestore_helper.dart';
import '../services/sql_helper.dart';
import '../services/weather_helper.dart';

class BuildWidgetsBase {
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();
  final WeatherHelper _weatherHelper = WeatherHelper();

  //Oyun platformlarını build ediyor.
  Widget buildPlatforms(String gameId) {
    return FutureBuilder(
        future: _gameHelper.getPlatforms(gameId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            List temparr = data;
            if (data == null) {
              return Text('Veri bulunamadı.');
            } else {
              if (temparr.length < 2) {
                return Row(
                  children: [
                    Icon(LineIcons.byName(data[0]), color: Colors.white),
                  ],
                );
              } else if (temparr.length < 3) {
                return Row(
                  children: [
                    Icon(LineIcons.byName(data[0]), color: Colors.white),
                    Icon(LineIcons.byName(data[1]), color: Colors.white),
                  ],
                );
              } else if (temparr.length < 4) {
                return Row(
                  children: [
                    Icon(LineIcons.byName(data[0]), color: Colors.white),
                    Icon(LineIcons.byName(data[1]), color: Colors.white),
                    Icon(LineIcons.byName(data[2]), color: Colors.white),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Icon(LineIcons.byName(data[0]), color: Colors.white),
                    Icon(LineIcons.byName(data[1]), color: Colors.white),
                    Icon(LineIcons.byName(data[2]), color: Colors.white),
                    Icon(LineIcons.byName(data[3]), color: Colors.white),
                  ],
                );
              }
            }
          } else {
            return Text('yükleniyor');
          }
        });
  }

  // gameImage i build ediyor.
  Widget buildGameImage(String gameId) {
    return FutureBuilder(
        future: SQLGameHelper.getGameImagesForId(gameId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                height: 152,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data![0]['gameImage'],
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, downloadProgress) => Material(
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
                              value: downloadProgress.progress,
                              color: Colors.black54,
                              strokeWidth: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Material(
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
            );
          }
        });
  }

  // routed gameImage i build ediyor.
  Widget buildGameImageRouted(Widget routePage, String gameId) {
    return FutureBuilder(
        future: SQLGameHelper.getGameImagesForId(gameId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => routePage));
                },
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 152,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data![0]['gameImage'],
                        fit: BoxFit.fill,
                        progressIndicatorBuilder: (context, url, downloadProgress) => Material(
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
                                  value: downloadProgress.progress,
                                  color: Colors.black54,
                                  strokeWidth: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
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

  //BackgroundImage i build ediyor.
  Widget buildBackgroundImage(String gameId, String screenshotId) {
    return FutureBuilder(
        future: SQLGameHelper.getGameImagesForId(gameId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: snapshot.data![0]['screenshot3'],
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                    child: SizedBox(
                      height: 64.0,
                      width: 64.0,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Colors.black54,
                        strokeWidth: 3.0,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                height: 64.0,
                width: 64.0,
                child: CircularProgressIndicator(
                  color: Colors.black54,
                  strokeWidth: 3.0,
                ),
              ),
            );
          }
        });
  }

  //Kullanıcıların verdiği puanın ortalamasını widget şeklinde getiriyor.
  Widget buildRatingBar(String gameId) {
    return FutureBuilder<Game?>(
      future: _gameHelper.readGame(gameId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List ratings = snapshot.data!.ratings;

          double ratingAVG = 0;
          for (dynamic element in ratings) {
            ratingAVG = ratingAVG + element;
          }
          ratingAVG = ratingAVG / ratings.length;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text('Puan: ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
              Text('(${ratings.length.toString()})',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: RatingBarIndicator(
                  rating: double.tryParse(ratingAVG.toString())!,
                  itemBuilder: (context, index) => Icon(
                    LineIcons.starAlt,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 25.0,
                  direction: Axis.horizontal,
                  unratedColor: Colors.white30,
                ),
              ),
              Text(ratingAVG.toStringAsFixed(1),
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          );
        } else {
          return Text(
            'Yükleniyor',
            style: TextStyle(color: Colors.white),
          );
        }
      },
    );
  }

  //Oyun adını build ediyor.
  Widget buildGameName(String gameId) {
    return FutureBuilder(
        future: _gameHelper.getGameName(gameId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Text(data.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500));
          } else {
            return Text('Yükleniyor');
          }
        });
  }

  //Oyun Yapımcısı adını build ediyor
  Widget buildGameMakerName(String gameId) {
    return FutureBuilder(
        future: _gameHelper.getGameMakerName(gameId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Text(data.toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500));
          } else {
            return Text('Yükleniyor');
          }
        });
  }
}

class BuildWidgets extends BuildWidgetsBase {
  //Sol kısımda Oyun Resmi, sağ kısımda oyun bilgilerini gösteren widget.
  Widget buildGameWidgetA(BuildContext context, AsyncSnapshot<List<Game?>> snapshot,
      {String currentUserID = ''}) {
    Widget gameImageAndName(
      BuildContext context,
      Game game,
      Widget routeName,
      Widget gameImage,
      Widget backgroundImage,
      Widget platforms,
      Widget rating,
    ) =>
        Dismissible(
          background: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 165,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.library_books_rounded,
                    size: 50,
                  ),
                  Text(
                    'Kütüphaneye Eklendi',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          secondaryBackground: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 165,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Beğenilenlere Eklendi',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
          key: UniqueKey(),
          onDismissed: (direction) async {
            //Sağa veya sola kaydırmaya göre beğenilenler yada kütüphaneye ekliyoruz.
            List tempArr = [game.gameId];
            if (direction == DismissDirection.endToStart) {
              final doc = _gameHelper.database.collection('users').doc(currentUserID);
              await doc.update({'userLikes': FieldValue.arrayUnion(tempArr)});
            } else {
              final doc = _gameHelper.database.collection('users').doc(currentUserID);
              await doc.update({'userLibrary': FieldValue.arrayUnion(tempArr)});
            }
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => routeName));
            },
            child: Material(
              elevation: 8,
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                height: 165,
                child: Stack(
                  children: [
                    backgroundImage,
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(12.0)),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: gameImage,
                          ),
                          VerticalDivider(),
                          Expanded(
                            child: SizedBox(
                              height: 140.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(game.gameName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(height: 6),
                                    Text(game.gameMakerName,
                                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                                    Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.symmetric(vertical: 6.0),
                                            child: Text('Platformlar: ',
                                                style: TextStyle(
                                                    color: Colors.white, fontWeight: FontWeight.w500))),
                                        platforms,
                                      ],
                                    ),
                                    rating,
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );

    //Oyunları Widget şeklinde liste olarak veriyor.
    getGameList(AsyncSnapshot<List<Game?>> snapshot) {
      return snapshot.data!
          .map((game) => Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
                child: gameImageAndName(
                  context,
                  game!,
                  GamePage(
                    gameId: game.gameId,
                    currentUserId: currentUserID,
                  ),
                  buildGameImage(game.gameId),
                  buildBackgroundImage(game.gameId, 'screenshot_3'),
                  buildPlatforms(game.gameId),
                  buildRatingBar(game.gameId),
                ),
              ))
          .toList();
    }

    if (snapshot.hasData) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: getGameList(snapshot),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(36.0),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.black,
          ),
        ),
      );
    }
  }

  //Sol kısımda Oyun Resmi, sağ kısımda oyun bilgilerini gösteren widget. Likes Page için değiştirildi.
  Widget buildGameWidgetAForLikes(
      BuildContext context, AsyncSnapshot<KgameUser?> snapshot, String currentUserID) {
    Widget gameImageAndName(BuildContext context, String gameId, Widget routeName, Widget gameImage,
        Widget gameName, Widget backgroundImage, Widget platforms, Widget ratings, Widget gameMakerName) {
      return Dismissible(
        background: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 165,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.library_books_rounded,
                  size: 50,
                ),
                Text(
                  'Kütüphaneye Eklendi',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        secondaryBackground: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 165,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Beğenilenlerden Kaldırıldı',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.favorite_border_rounded,
                  size: 50,
                ),
              ],
            ),
          ),
        ),
        key: UniqueKey(),
        onDismissed: (direction) async {
          //Sağa veya sola kaydırmaya göre beğenilenler yada kütüphaneye ekliyoruz.
          List tempArr = [gameId];
          if (direction == DismissDirection.endToStart) {
            final doc = _gameHelper.database.collection('users').doc(currentUserID);
            await doc.update({'userLikes': FieldValue.arrayRemove(tempArr)});
          } else {
            final doc = _gameHelper.database.collection('users').doc(currentUserID);
            await doc.update({'userLibrary': FieldValue.arrayUnion(tempArr)});
          }
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => routeName));
          },
          child: Material(
            elevation: 8,
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              height: 165,
              child: Stack(
                children: [
                  backgroundImage,
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(12.0)),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: gameImage,
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: SizedBox(
                          height: 140.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                gameName,
                                SizedBox(height: 6),
                                gameMakerName,
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 6.0),
                                      child: Text(
                                        'Platformlar: ',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    platforms,
                                  ],
                                ),
                                ratings,
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    getUserLikes(AsyncSnapshot<KgameUser?> snapshot) {
      final user = snapshot.data;
      return user?.userLikes
          .map((gameId) => Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
              child: gameImageAndName(
                context,
                gameId,
                GamePage(
                  gameId: gameId,
                  currentUserId: currentUserID,
                ),
                buildGameImage(gameId),
                buildGameName(gameId),
                buildBackgroundImage(gameId, 'screenshot_1'),
                buildPlatforms(gameId),
                buildRatingBar(gameId),
                buildGameMakerName(gameId),
              )))
          .toList();
    }

    if (snapshot.hasData) {
      return MySingleChildScrollView(
        Axis.vertical,
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: getUserLikes(snapshot)!.isEmpty
                ? [Center(child: Text('Henüz bir oyunu beğenmediniz.'))]
                : getUserLikes(snapshot)!,
          ),
        ),
      );
    } else {
      return Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 3,
      ));
    }
  }

  //Oyun resminden oluşan widget.
  Widget buildGameWidgetB(AsyncSnapshot<List<Game?>> snapshot, String currentUserId) {
    getGameList(AsyncSnapshot<List<Game?>> snapshot) {
      return snapshot.data!
          .map((game) => buildGameImageRouted(
              GamePage(
                gameId: game!.gameId,
                currentUserId: currentUserId,
              ),
              game.gameId))
          .toList();
    }

    if (snapshot.hasData) {
      return MySingleChildScrollView(
        Axis.horizontal,
        Row(
          children: getGameList(snapshot),
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
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
            ],
          ));
    }
  }

  //FPS kategorisini build eder.
  Widget buildGameWidgetBForFps(AsyncSnapshot<List<Game?>> snapshot) {
    getGames(AsyncSnapshot<List<Game?>> snapshot) {
      return snapshot.data!
          .map((game) => buildGameImageRouted(GamePage(gameId: game!.gameId), game.gameId))
          .toList();
    }

    if (snapshot.hasData) {
      return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(18),
        childAspectRatio: (1 / 1.52),
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        crossAxisCount: 3,
        children: getGames(snapshot),
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
  }

  //Racing kategorisinde listelenen widgetların build edilmesi.
  Widget buildGameWidgetC(BuildContext context, AsyncSnapshot<List<Game?>> snapshot) {
    //Firestore dan gelen veriye göre listelenecek widget ı build ediyor.
    Widget gameImageAndName(
      BuildContext context,
      Widget routeName,
      Widget gameImage,
      String gameName,
      Widget backgroundImage,
      Widget ratings,
      Widget platforms,
    ) =>
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => routeName));
            },
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                height: 260,
                child: Stack(
                  children: [
                    backgroundImage,
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12.0)),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: gameImage,
                          ),
                          Column(
                            children: [
                              Text(
                                gameName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text('Platformlar: ',
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                                  platforms,
                                ],
                              ),
                              ratings,
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

    //listview e build ettiğimiz GameImageAndName widgetlarını liste olarak veriyor.
    getGames(AsyncSnapshot<List<Game?>> snapshot) {
      return snapshot.data!.map((game) {
        return gameImageAndName(
          context,
          GamePage(gameId: game!.gameId),
          buildGameImage(game.gameId),
          game.gameName,
          buildBackgroundImage(game.gameId, 'screenshot_1'),
          buildRatingBar(game.gameId),
          buildPlatforms(game.gameId),
        );
      }).toList();
    }

    if (snapshot.hasData) {
      return Column(
        children: getGames(snapshot),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          elevation: 8,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 165,
            child: Center(
              child: Text('Yükleniyor..', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      );
    }
  }

  //Game Library içinde listelenen widgetların build edilmesi.
  Widget buildGameWidgetCForLib(
      BuildContext context, AsyncSnapshot<KgameUser?> snapshot, String currentUserID) {
    //Firestore dan gelen veriye göre listelenecek widget ı build ediyor.
    Widget gameImageAndName(
      BuildContext context,
      Widget routeName,
      Widget gameImage,
      Widget gameName,
      Widget backgroundImage,
      Widget ratings,
      Widget platforms,
    ) =>
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => routeName));
            },
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                height: 260,
                child: Stack(
                  children: [
                    backgroundImage,
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12.0)),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: gameImage,
                          ),
                          Column(
                            children: [
                              gameName,
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text('Platformlar: ',
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                                  platforms,
                                ],
                              ),
                              ratings,
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

    //listview e build ettiğimiz GameImageAndName widgetlarını liste olarak veriyor.
    getGames(AsyncSnapshot<KgameUser?> snapshot) {
      final user = snapshot.data;
      return user!.userLibrary
          .map((gameId) => gameImageAndName(
              context,
              GamePage(
                gameId: gameId,
                currentUserId: currentUserID,
              ),
              buildGameImage(gameId),
              buildGameName(gameId),
              buildBackgroundImage(gameId, 'screenshot_3'),
              buildRatingBar(gameId),
              buildPlatforms(gameId)))
          .toList();
    }

    if (snapshot.hasData) {
      return Column(
        children: getGames(snapshot),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          elevation: 8,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
            height: 165,
            child: Center(
              child: Text('Yükleniyor..', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      );
    }
  }

  //Profil ekranını build eder.
  Widget buildUser(BuildContext context, AsyncSnapshot snapshot) {
    //gridview de kullanılan widget.
    Widget gridViewItem(IconData icon, Widget routePage, Color color) => GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => routePage));
          },
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(36.0),
                  elevation: 6.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      size: 45.0,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

    //profil sayfasının build widgeti.
    Widget buildUserPage(KgameUser user, Widget weather) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 6.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    maxRadius: 48.0,
                    minRadius: 48.0,
                    backgroundImage: AssetImage('assets/images/user_avatars/male_avatar.png'),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${user.userName} ${user.userSurname}',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${user.userCity} | ${user.userCountry}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Divider(),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                childAspectRatio: (1.5 / 1),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: <Widget>[
                  gridViewItem(Icons.perm_identity_rounded, UserInformationPage(currentUser: user),
                      Theme.of(context).primaryColor),
                  // gridViewItem(Icons.favorite_border_rounded, LikesPage(currentUserID: user.id.toString()),
                  //     Theme.of(context).primaryColor),
                  gridViewItem(Icons.sports_esports_rounded, GameLibraryPage(currentUserID: user.id),
                      Theme.of(context).primaryColor),

                  gridViewItem(Icons.donut_small_rounded, ChartsPage(), Theme.of(context).primaryColor),
                  gridViewItem(Icons.settings_rounded, SettingsPage(), Theme.of(context).primaryColor),
                ],
              ),
              weather,
            ],
          ),
        );

    //Hava durumu apisinden gelen veri ile havadurumunu gösteriyor.
    Widget buildweather(KgameUser user) => FutureBuilder<Weather?>(
          future: _weatherHelper.readDataForCity(user.userCity),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;

              IconData? weatherIcon;
              if (data.currentDescId > 801) {
                weatherIcon = Icons.cloud;
              } else if (data.currentDescId == 801) {
                weatherIcon = LineIcons.cloudWithSun;
              } else if (data.currentDescId == 800) {
                weatherIcon = LineIcons.sun;
              } else if (data.currentDescId > 700) {
                weatherIcon = LineIcons.wind;
              } else if (data.currentDescId >= 600) {
                weatherIcon = LineIcons.snowflake;
              } else if (data.currentDescId >= 505) {
                weatherIcon = LineIcons.cloudWithRain;
              } else if (data.currentDescId >= 500) {
                weatherIcon = LineIcons.cloudWithSunAndRain;
              } else if (data.currentDescId >= 300) {
                weatherIcon = LineIcons.cloudWithRain;
              } else if (data.currentDescId >= 200) {
                weatherIcon = LineIcons.lightningBolt;
              }

              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  user.userCity.toUpperCase(),
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  user.userCountry.toUpperCase(),
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      weatherIcon,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      '${data.currentTemp.toStringAsFixed(0)}°C',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  data.currentDescription.toUpperCase(),
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 3,
                          ),
                        ),
                      )),
                ),
              );
            }
          },
        );

    if (snapshot.hasData) {
      final user = snapshot.data;
      return user == null
          ? Center(
              child: Text('No user'),
            )
          : buildUserPage(user, buildweather(user));
    } else {
      return CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.black,
      );
    }
  }

  //Listelenen kategorilerin build edilmesi.
  Widget buildCategories(BuildContext context, AsyncSnapshot<List<Categories?>> snapshot) {
    //Listelenecek widget
    Widget categories(
      BuildContext context,
      String categorieRouteName,
      String categorieName,
      Widget categorieImage,
    ) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/$categorieRouteName');
            },
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    categorieImage,
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                          child: Text(
                        categorieName.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

    Widget buildCategoryImage(String categoryId) {
      return FutureBuilder(
          future: SQLCategoryHelper.getCategoryImagesForId(categoryId),
          builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data![0]['categoryImage'],
                      fit: BoxFit.fill,
                      progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Center(
                            child: SizedBox(
                              width: 36.0,
                              height: 36.0,
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Colors.black,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    )),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Center(
                    child: SizedBox(
                      width: 36.0,
                      height: 36.0,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                ),
              );
            }
          });
    }

    //Tüm kategorileri liste halinde çekiyor.
    getGames(AsyncSnapshot<List<Categories?>> snapshot) {
      return snapshot.data!
          .map(
            (category) => categories(
                context, category!.categoryName, category.categoryName, buildCategoryImage(category.id)),
          )
          .toList();
    }

    if (snapshot.hasData) {
      return Column(
        children: getGames(snapshot),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 150.0,
          width: double.infinity,
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
      );
    }
  }

  //Oyun yapımcısı ekranını build eder.
  Widget buildGameMakerPage(AsyncSnapshot<Game?> snapshot) {
    Widget makerPage(Game game, Widget makerImage) => Padding(
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
                            game.gameMakerName,
                            style: TextStyle(fontSize: 24.0),
                          )),
                    ),
                    makerImage,
                  ],
                ),
              ),
              Text(
                'Hakkında',
                style: TextStyle(fontSize: 18.0),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 24.0), child: Text(game.gameMakerDesc)),
            ],
          ),
        );

    //Game Maker sayfasında ki logoyu build ediyor.
    Widget buildMakerImage(String gameMakerId) {
      return FutureBuilder(
        future: SQLMakerHelper.getGameMakerImagesForId(gameMakerId),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: snapshot.data![0]['gameMakerImage'],
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return Flexible(
              flex: 2,
              child: SizedBox(
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

    if (snapshot.hasData) {
      final game = snapshot.data;
      return makerPage(game!, buildMakerImage(game.gameMakerId));
    } else {
      return CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.black,
      );
    }
  }
}
