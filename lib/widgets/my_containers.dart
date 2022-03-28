import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kgamepedia/screens/game_maker_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_behavior.dart';

Widget GameImage(BuildContext context, String routeName, bool onTap, String imageName) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          onTap == false ? null : Navigator.pushNamed(context, routeName);
        },
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(8.0),
          child: SizedBox(
            height: 152,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/game_images/$imageName',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );

Widget GameScreenShotImage(String imageName) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(8.0),
        child: SizedBox(
          height: 135,
          width: 225,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/game_screenshots/$imageName',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );

Widget GameImageAndName(BuildContext context, String routeName, Widget gameImage, String gameName,
        String backgroundImage, double rating, int ratingCounter, List platforms, String gameMakerName) =>
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Material(
          elevation: 8,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 165,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset('assets/images/game_screenshots/${backgroundImage}.jpg',
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(12.0)),
                ),
                Row(
                  children: [
                    gameImage,
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 140.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(gameName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500)),
                            SizedBox(height: 6),
                            Text(gameMakerName,
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 6.0),
                                    child: Text('Platformlar: ',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                                platforms[0],
                                platforms[1],
                                platforms[2],
                                platforms[3],
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 3.0),
                                    child: Text('Puan: ',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                                Text('$ratingCounter ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                                RatingBarIndicator(
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  rating: rating,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  ),
                                  itemCount: 5,
                                  itemSize: 25.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                          ],
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

Widget GameImageAndName2(
  BuildContext context,
  String routeName,
  Widget gameImage,
  String gameName,
  String backgroundImage,
  double rating,
  int ratingCounter,
  List platforms,
) =>
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 260,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/images/game_screenshots/${backgroundImage}.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12.0)),
                ),
                Column(
                  children: [
                    gameImage,
                    Column(
                      children: [
                        Text(
                          gameName,
                          style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Platformlar: ',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                            platforms[0],
                            platforms[1],
                            platforms[2],
                            platforms[3],
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 6.0),
                                child: Text('Puan: ',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                            Text('${ratingCounter} ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                            RatingBarIndicator(
                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                              rating: rating,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              itemCount: 5,
                              itemSize: 25.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget GameScreenContainer(
  BuildContext context,
  Widget gameImage,
  String gameName,
  List platforms,
  Widget gameRating,
  String gameAdress,
  String descriptionText,
  String screnshot1,
  String screnshot2,
  String screnshot3,
  String screnshot4,
  String screnshot5,
  String gameMakerName,
  String gameMakerDesc,
  String gameMakerImage,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              gameImage,
              SizedBox(width: 12.0),
              Expanded(
                child: SizedBox(
                  height: 152.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameName,
                        style: TextStyle(fontSize: 22.0),
                      ),
                      SizedBox(height: 6.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameMakerPage(
                                  gameMakerName: gameMakerName,
                                  gameMakerDesc: gameMakerDesc,
                                  gameMakerImage: gameMakerImage,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            gameMakerName,
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                          )),
                      SizedBox(height: 6.0),
                      Row(
                        children: [
                          Text('Platformlar: ', style: TextStyle(fontWeight: FontWeight.w500)),
                          platforms[0],
                          platforms[1],
                          platforms[2],
                          platforms[3],
                        ],
                      ),
                      gameRating,
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
                      child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                              child: Text(
                            descriptionText,
                            style: TextStyle(fontSize: 16.0, color: Colors.black54),
                          ))))
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
                ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GameScreenShotImage(screnshot1),
                          GameScreenShotImage(screnshot2),
                          GameScreenShotImage(screnshot3),
                          GameScreenShotImage(screnshot4),
                          GameScreenShotImage(screnshot5),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFFFDE15))),
              onPressed: () {
                launchURL(gameAdress);
              },
              child: Text(
                'Satın Al',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Başlatılamadı $url';
  }
}

Widget Categories(BuildContext context, Widget categoie, String categorieName, String categorieImage) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => categoie));
        },
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            height: 150,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/images/categorie_images/$categorieImage.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
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
                    categorieName,
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
