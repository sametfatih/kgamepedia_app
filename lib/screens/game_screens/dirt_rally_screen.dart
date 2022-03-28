import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class DirtRallyPage extends StatefulWidget {
  static String routeName = '/routeDirtPage';
  final List<Icon> platforms = <Icon>[
    Icon(LineIcons.windows, color: Colors.white),
    Icon(LineIcons.apple, color: Colors.white),
    Icon(null),
    Icon(null),
  ];
  final List<Icon> platforms2 = <Icon>[
    Icon(LineIcons.windows),
    Icon(LineIcons.apple),
    Icon(null),
    Icon(null),
  ];
  double rating = 2;
  int ratingCounter = 3;
  @override
  _DirtRallyPageState createState() => _DirtRallyPageState();
}

class _DirtRallyPageState extends State<DirtRallyPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'Dirt Rally 2.0'),
        body: GameScreenContainer(
          context,
          GameImage(context, DirtRallyPage.routeName, false, 'dirt_rally.jpg'),
          'Dirt Rally 2.0',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/690790/DiRT_Rally_20/',
          "DiRT Rally 2.0, en küçük hatanın yarışını sona erdirebileceğini bilerek, dünyanın dört bir yanından ikonik ralli konumları arasında en güçlü arazi araçlarıyla oynaman için sana meydan okuyor.",
          'dirt_rally_screenshot_1.jpg',
          'dirt_rally_screenshot_2.jpg',
          'dirt_rally_screenshot_3.jpg',
          'dirt_rally_screenshot_4.jpg',
          'dirt_rally_screenshot_5.jpg',
          'Electronic Arts',
          "Electronic Arts Inc., merkezi Redwood, Kaliforniya'da bulunan Amerikalı bir video oyun şirketi. Mayıs 2020 itibarıyla Amerika ve Avrupa'da kâr ve piyasa değeri bakımından ikinci en büyük oyun şirketidir. Hisseleri NASDAQ'da EA ismiyle işlem görmektedir. Dünya çapında pek çok stüdyosu vardır.",
          'electronicarts.png',
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
