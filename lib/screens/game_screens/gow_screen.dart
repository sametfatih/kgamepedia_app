import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class GOWPage extends StatefulWidget {
  static String routeName = '/routeGOWPage';
  final List<Icon> platforms = <Icon>[
    Icon(LineIcons.windows, color: Colors.white),
    Icon(LineIcons.xbox, color: Colors.white),
    Icon(LineIcons.playstation, color: Colors.white),
    Icon(null),
  ];
  final List<Icon> platforms2 = <Icon>[
    Icon(LineIcons.windows),
    Icon(LineIcons.xbox),
    Icon(LineIcons.playstation),
    Icon(null),
  ];
  double rating = 2;
  int ratingCounter = 2;

  @override
  _GOWPageState createState() => _GOWPageState();
}

class _GOWPageState extends State<GOWPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'God Of War'),
        body: GameScreenContainer(
          context,
          GameImage(context, GOWPage.routeName, false, 'gow.jpg'),
          'God Of War',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/1593500/God_of_War/',
          'Olimpos Tanrılarından aldığı intikamın üzerinden yıllar geçen Kratos, artık İskandinav Tanrılarının ve canavarlarının diyarında sıradan bir insan olarak yaşıyor. Bu sert ve acımasız dünyada hayatta kalabilmek için savaşmak ve oğluna da aynısını öğretmek zorunda.',
          'gow_screenshot_1.jpg',
          'gow_screenshot_2.jpg',
          'gow_screenshot_3.jpg',
          'gow_screenshot_4.jpg',
          'gow_screenshot_5.jpg',
          'Sony',
          "Sony Interactive Entertainment, Sony'nin video oyunu ve dijital eğlence alanında faaliyet gösteren yan kuruluşudur. Şirket, 16 Kasım 1993'te Sony Computer Entertainment adıyla PlayStation oyun konsollarını üretmek amacıyla kuruldu.",
          'sony.jpg',
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
