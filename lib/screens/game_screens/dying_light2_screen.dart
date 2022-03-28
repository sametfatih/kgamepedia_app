import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class DyigLight2Page extends StatefulWidget {
  static String routeName = '/routeDyingLightPage';
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
  double rating = 2.5;
  int ratingCounter = 4;
  @override
  _Doom3PageState createState() => _Doom3PageState();
}

class _Doom3PageState extends State<DyigLight2Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'DYING LIGHT 2'),
        body: GameScreenContainer(
          context,
          GameImage(context, DyigLight2Page.routeName, false, 'dyinglight2.jpg'),
          'Dying Light 2',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/534380/Dying_Light_2_Stay_Human/',
          "Virüs kazandı ve medeniyet Karanlık Çağ'a geri döndü. İnsanlığın son yerleşkelerinden biri olan Şehir, yıkılmanın eşiğinde. Hayatta kalmak için çevikliğini ve dövüş yeteneklerini kullan ve dünyayı yeniden şekillendir. Seçimlerin herkesin kaderini belirleyecek.",
          'dyinglight2_1.jpg',
          'dyinglight2_2.jpg',
          'dyinglight2_3.jpg',
          'dyinglight2_4.jpg',
          'dyinglight2_5.jpg',
          'Techland',
          "Techland S.A. Paweł Marchewka tarafından 1991 yılında kurulan Polonya merkezli video oyunu geliştirme ve yayımlama şirketidir. Call of Juarez, Dead Island ve Dying Light serileri ile tanınır.",
          'techland.png',
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
