import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/my_appbars.dart';
import '../../widgets/my_containers.dart';

class MinecraftPage extends StatefulWidget {
  static String routeName = '/routeMinecraftPage';
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
  int ratingCounter = 4;

  @override
  _MinecraftPageState createState() => _MinecraftPageState();
}

class _MinecraftPageState extends State<MinecraftPage> {
  @override
  Widget build(BuildContext context) {
    MinecraftPage sad = MinecraftPage();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: myGameAppBar(context, 'Minecraft'),
        body: GameScreenContainer(
          context,
          GameImage(context, MinecraftPage.routeName, false, 'minecraft.jpg'),
          'Minecraft',
          widget.platforms2,
          MyRatingBar(),
          'https://www.minecraft.net/tr-tr/store/minecraft-windows10',
          'Rastgele üretilen dünyaları keşfedin ve en basit evlerden en görkemli kalelere kadar muhteşem şeyler inşa edin. Yaratıcı modunda sınırsız kaynakla oynayın ya da hayatta kalma modunda en derinleri kazarak silah ve zırh üretip tehlikeli mobları püskürtün. Sarp dağlara tırmanın, karmaşık mağaraları keşfedin ve geniş maden damarlarını kazın. Bereketli mağara ve damlataş mağarası biyomlarını keşfedin. Ne kadar bilgili bir mağara kaşifi ve usta bir dağcı olduğunuzu göstermek için dünyanızı mumlarla aydınlatın!',
          'minecraft_screenshot_1.jpg',
          'minecraft_screenshot_2.jpg',
          'minecraft_screenshot_3.jpg',
          'minecraft_screenshot_4.jpg',
          'minecraft_screenshot_5.jpg',
          'Mojang',
          "Mojang Studios, Mayıs 2009'da İsveç'te kurulmuş video oyunu geliştirici şirketi. Minecraft, Scrolls gibi oyunların yaratıcısıdır. 2014 yılında Microsoft tarafından satın alınmıştır. Mojang'ın kurucusu Markus Alexej Persson'dur. Merkezi İsveç Maria Skolgata Stockholm'dadır.",
          'mojang.png',
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
