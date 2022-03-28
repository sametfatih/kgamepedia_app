import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class GtaVPage extends StatefulWidget {
  static String routeName = '/routeGtaVPage';
  final List<Icon> platforms = <Icon>[
    Icon(LineIcons.windows, color: Colors.white),
    Icon(LineIcons.apple, color: Colors.white),
    Icon(LineIcons.xbox, color: Colors.white),
    Icon(LineIcons.playstation, color: Colors.white),
  ];
  final List<Icon> platforms2 = <Icon>[
    Icon(LineIcons.windows),
    Icon(LineIcons.apple),
    Icon(LineIcons.xbox),
    Icon(LineIcons.playstation),
  ];
  double rating = 2;
  int ratingCounter = 5;
  @override
  _GtaVPageState createState() => _GtaVPageState();
}

class _GtaVPageState extends State<GtaVPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'GTA V'),
        body: GameScreenContainer(
          context,
          GameImage(context, GtaVPage.routeName, false, 'gtav.jpg'),
          'GTA V',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/271590/Grand_Theft_Auto_V/',
          'Grand Theft Auto Vin PC sürümü, oyunculara 4k ve ötesinde çözünürlükle ve saniyede 60 kare tazeleme hızıyla Los Santos ve Blaine County dünyasını keşfetme fırsatını sunuyor.',
          'gtav_screenshot_1.jpg',
          'gtav_screenshot_2.jpg',
          'gtav_screenshot_3.jpg',
          'gtav_screenshot_4.jpg',
          'gtav_screenshot_5.jpg',
          'Rockstar Games',
          "Rockstar Games, diğer bir adı Rockstar NYC olan, Take-Two Interactive'e bağlı uluslararası video oyun yapımcı firması. Firma ABD New York'ta kurulmuştur.",
          'rockstar.png',
        ),
      ),
    );
  }

  Widget MyRatingBar() => Row(
        children: [
          Text('${widget.ratingCounter}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          RatingBarIndicator(
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            rating: widget.rating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.red,
            ),
            itemCount: 5,
            itemSize: 25.0,
            direction: Axis.horizontal,
          ),
          TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.grey.shade300),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Oyunu Puanla'),
                    content: RatingBar.builder(
                      initialRating: widget.rating,
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
                        widget.rating = (widget.rating + rating) / 2;
                        print(widget.rating);
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.grey.shade300),
                            foregroundColor: MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          Navigator.pop(context, 'iptal');
                        },
                        child: const Text('İptal'),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.grey.shade300),
                            foregroundColor: MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          setState(() {
                            widget.ratingCounter++;
                          });
                          Navigator.pop(context, 'Puanla');
                        },
                        child: const Text('Puanla'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Oyunu Puanla'))
        ],
      );
}
