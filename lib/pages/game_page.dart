import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:kgamepedia/models/comment.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/models/user.dart';
import 'package:kgamepedia/pages/comments_page.dart';
import 'package:kgamepedia/pages/game_maker_page.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/services/sql_helper.dart';
import 'package:kgamepedia/services/url_launcher.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:line_icons/line_icons.dart';

class GamePage extends StatefulWidget {
  final String gameId;
  final String currentUserId;
  const GamePage({Key? key, required this.gameId, this.currentUserId = ''}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();
  final BuildWidgets _buildWidgets = BuildWidgets();

  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarB(context, 'KGAMES'),
        body: FutureBuilder<Game?>(
            future: _gameHelper.readGame(widget.gameId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final game = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                  child: MySingleChildScrollView(
                    Axis.vertical,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                          child: Row(
                            children: [
                              //Oyun ekranında sol üstteki image'i getirir.
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: _buildWidgets.buildGameImage(game!.gameId),
                              ),
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
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.w500),
                                        ),
                                      ),

                                      SizedBox(height: 6.0),
                                      //Oyun ekranındaki platformlar
                                      Row(
                                        children: [
                                          Text('Platformlar: ',
                                              style: TextStyle(fontWeight: FontWeight.w500)),
                                          buildPlatforms(game.gameId),
                                        ],
                                      ),
                                      //oyun ekranındaki rating bar
                                      buildRatingBar(game.gameId),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        //Oyun ekranındaki en altta bulunan satın al butonunu oluşturuluyor.
                        // Görüntülenen oyuna göre veritabanından o oyunun game Link verisini çekip o linke url launcher ile yönlendirme yapılıyor.
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                              ),
                              onPressed: () {
                                launchURL(game.gameLink);
                              },
                              child: Text(
                                'Satın Al',
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                          ),
                        ),

                        //Hakkında
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hakkında',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                game.gameDescription,
                                style: TextStyle(color: Colors.black54, fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        //Ekran görüntüleri
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ekran Görüntüleri',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              MySingleChildScrollView(
                                Axis.horizontal,
                                buildGameScreenShotImage(game.gameId),
                              ),
                            ],
                          ),
                        ),
                        //Yorumlar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Yorumlar',
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Comments(gameId: game.gameId)));
                                      },
                                      child: Text('Tümünü görüntüle')),
                                ],
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              StreamBuilder<List<Comment>>(
                                  stream: _gameHelper.readComments(game.gameId, 3),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final comments = snapshot.data;
                                      return Column(
                                          children:
                                              comments!.map((comment) => buildComment(comment)).toList());
                                    } else {
                                      return Text('Yükleniyor');
                                    }
                                  }),
                              Divider(),
                              TextFormField(
                                controller: _commentController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'Yorum yazın.',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      backgroundImage:
                                          AssetImage('assets/images/user_avatars/male_avatar.png'),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      final comment = Comment(
                                          userId: widget.currentUserId,
                                          commentText: _commentController.text.trim().toString(),
                                          commentDate: DateTime.now());
                                      await createComment(comment, game.gameId);
                                      _commentController.clear();
                                    },
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ),
                                onFieldSubmitted: (val) async {
                                  final comment = Comment(
                                      userId: widget.currentUserId,
                                      commentText: _commentController.text.trim().toString(),
                                      commentDate: DateTime.now());
                                  await createComment(comment, game.gameId);
                                  _commentController.clear();
                                },
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.black,
                  ),
                );
              }
            }),
      ),
    );
  }

  //yorum oluşturuyor.
  Future createComment(Comment comment, String gameId) async {
    DocumentReference docComment =
        FirebaseFirestore.instance.collection('games').doc(gameId).collection('comments').doc();
    comment.commentId = docComment.id;
    final commentJson = comment.toJson();
    await docComment.set(commentJson);
  }

  //oyun sayfasındaki yorum widgetinin build edilmesi.
  Widget buildComment(Comment comment) {
    Widget userNamebuild() => FutureBuilder<KgameUser?>(
        future: FirebaseUserHelper.readUser(comment.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return Text(user!.userName, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500));
          } else {
            return Text('Yükleniyor');
          }
        });

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
            elevation: 6.0,
            borderRadius: BorderRadius.circular(24),
            child: CircleAvatar(
              minRadius: 24,
              maxRadius: 24,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              backgroundImage: AssetImage('assets/images/user_avatars/male_avatar.png'),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    userNamebuild(),
                    SizedBox(
                      width: 6.0,
                    ),
                    Text(DateFormat('| MMM d, h:mm').format(comment.commentDate)),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(comment.commentText, style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Kullanıcıların verdiği puanın ortalamasını widget şeklinde getiriyor.
  Widget buildRatingBar(String gameId) {
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
                color: Colors.amber,
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
          Flexible(
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
  Widget buildPlatforms(String gameId) {
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

  //Oyun alttaki screenhot imagelerini getirir.
  Widget buildGameScreenShotImage(String gameId) {
    Widget screenshotImage(String screenshotUrl) => Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8.0),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: 135,
              width: 225,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: screenshotUrl,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Material(
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
        );

    return FutureBuilder(
        future: SQLGameHelper.getGameImagesForId(gameId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data;

            return Row(
              children: [
                screenshotImage(data[0]['screenshot1']),
                screenshotImage(data[0]['screenshot2']),
                screenshotImage(data[0]['screenshot3']),
                screenshotImage(data[0]['screenshot4']),
                screenshotImage(data[0]['screenshot5']),
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
}
