import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class CSGOPage extends StatefulWidget {
  static String routeName = '/routeCSGOPage';
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
  int ratingCounter = 3;
  @override
  _CSGOPageState createState() => _CSGOPageState();
}

class _CSGOPageState extends State<CSGOPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'Counter Strike Global Offensive'),
        body: GameScreenContainer(
          context,
          GameImage(context, CSGOPage.routeName, false, 'csgo.jpg'),
          'Counter Strike Global Offensive',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/730/CounterStrike_Global_Offensive/',
          'Counter-Strike: Global Offensive (CS: GO), 19 yıl önce ilk çıktığında öncülük ettiği takım tabanlı aksiyon oyununu bir üst seviyeye taşıyor. CS:GO yeni haritalar, karakterler, silahlar ve oyun modları, ayrıca klasik CS içeriğinin (de_dust2 vb.) güncellenmiş sürümlerini sunuyor.',
          'csgo_screenshot_1.jpg',
          'csgo_screenshot_2.jpg',
          'csgo_screenshot_3.jpg',
          'csgo_screenshot_4.jpg',
          'csgo_screenshot_5.jpg',
          'Valve',
          "Valve Corporation; Bellevue, Washington merkezli, Ağustos 1996'da eski Microsoft çalışanları Gabe Newell ve Mike Harrington tarafından kurulan video oyunu geliştiricisi ve video oyunu yayımcısı şirket.",
          'valve.jpg',
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
