import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class Back4BloodPage extends StatefulWidget {
  static String routeName = '/routeBack4BloodPage';
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
  int ratingCounter = 1;

  @override
  _Back4BloodPageState createState() => _Back4BloodPageState();
}

class _Back4BloodPageState extends State<Back4BloodPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'Back 4 Blood'),
        body: GameScreenContainer(
          context,
          GameImage(context, Back4BloodPage.routeName, false, 'back_4_blood.jpg'),
          'Back 4 Blood',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/924970/Back_4_Blood/',
          "Back 4 Blood, otoriteler tarafından çok beğenilen Left 4 Dead serisinin yaratıcılarının elinden çıkan, heyecan verici bir eşli birinci şahıs nişancı oyunudur. Ridden'a karşı verilen savaşın merkezindesin. Bir zamanlar insan olan bu korkunç yaratıklar, taşıdıkları ölümcül bir parazit yüzünden, son medeniyet kırıntısını bile mideye indirmek üzereler. İnsanoğlunun varoluşu tehlikedeyken, Ridden'ı ortadan kaldırıp dünyanın kontrolünü yeniden ele alma görevi sen ve arkadaşlarına kaldı.",
          'back_4_blood_screenshot_1.jpg',
          'back_4_blood_screenshot_2.jpg',
          'back_4_blood_screenshot_3.jpg',
          'back_4_blood_screenshot_4.jpg',
          'back_4_blood_screenshot_5.jpg',
          'Warner Bros.',
          "Warner Bros. Interactive Entertainment, Amerika Birleşik Devletleri merkezli bir video oyunu şirketidir. Şirket, Ocak 2004 tarihinde Jon Burton ve Andy Ingram tarafından kurulmuş olup Warner Bros. Home Entertainment.'in bir yan kuruluşudur. Şirketin merkezi Kaliforniya'nın Burbank kentinde yer almaktadır.",
          'warnerbros.png',
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
