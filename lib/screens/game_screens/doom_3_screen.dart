import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_containers.dart';

class Doom3Page extends StatefulWidget {
  static String routeName = '/routeDOOM3Page';
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
  double rating = 2.5;
  int ratingCounter = 7;
  @override
  _Doom3PageState createState() => _Doom3PageState();
}

class _Doom3PageState extends State<Doom3Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'DOOM 3'),
        body: GameScreenContainer(
          context,
          GameImage(context, Doom3Page.routeName, false, 'doom_3.jpg'),
          'DOOM 3',
          widget.platforms2,
          MyRatingBar(),
          'https://store.steampowered.com/app/9050/DOOM_3/',
          "A massive demonic invasion has overwhelmed the Union Aerospace Corporation's (UAC) Mars Research Facility, leaving only chaos and horror in its wake. As one of only a few survivors, you must fight your way to hell and back against a horde of evil monsters.",
          'doom_3_screenshot_1.jpg',
          'doom_3_screenshot_2.jpg',
          'doom_3_screenshot_3.jpg',
          'doom_3_screenshot_4.jpg',
          'doom_3_screenshot_5.jpg',
          'Activision',
          "Activision, bilgisayar oyunları dağıtımı yapan firmadır. Dağıtımını üstlendiği oyunlar arasında Call of Duty, Quake Doom, Total War, Tony Hawk, Soldier of Fortune, Spider-Man, Guitar Hero gibi seriler bulunmaktadır.",
          'activision.png',
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
