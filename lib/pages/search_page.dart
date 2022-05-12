import 'package:flutter/material.dart';
import 'package:kgamepedia/models/game.dart';
import 'package:kgamepedia/widgets/build_widgets.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:line_icons/line_icons.dart';

import '../services/firebase_firestore_helper.dart';

class SearchPage extends StatefulWidget {
  final String? currentUserID;
  const SearchPage({Key? key, required this.currentUserID}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

//popup menudeki item valuelar için kullanıldı.
enum _MenuValues { game, category, gameMaker, ascdesc }

class _SearchPageState extends State<SearchPage> {
  final FirebaseGameHelper _gameHelper = FirebaseGameHelper();
  final BuildWidgets __buildWidgets = BuildWidgets();
  String tempSearch = '';
  String userSelect = 'gameName'; //default olarak Oyun Adı ile arama yapılması sağlandı.
  FocusNode focusSearchForm = FocusNode(); //search page açıldığında otomatik focus yapılması için kullanıldı.

  /* category[0] , oyun checkbox değeri olarak kullanıldı.
     category[1] , kategori checkbox değeri olarak kullanıldı.
     category[2] , oyun yapımcısı checkbox değeri olarak kullanıldı.
     category[3] , a-z ve z-a sıralama checkbox değeri olarak kullanıldı.
  */
  List category = [true, false, false, true]; // popupmenubutton üzerindeki checkbox yönetimi için kullanıldı.

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).autofocus(focusSearchForm);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: MySingleChildScrollView(
        Axis.vertical,
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 8.0, left: 12.0, right: 12.0),
              child: TextFormField(
                focusNode: focusSearchForm,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black54)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black54)),
                  hintText: 'Ara',
                  hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(Icons.search_outlined, color: Theme.of(context).iconTheme.color),
                  suffixIcon: searchPopupMenu(),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      if (category[0] == true || category[2] == true) {
                        tempSearch = value[0].toUpperCase() + value.substring(1, value.length).trim();
                      } else {
                        tempSearch = value.toLowerCase().trim();
                      }
                    },
                  );
                },
              ),
            ),
            StreamBuilder<List<Game>>(
                stream: _gameHelper.readGamesForSearch(userSelect, tempSearch, category),
                builder: (context, snapshot) =>
                    __buildWidgets.buildGameWidgetA(context, snapshot, currentUserID: widget.currentUserID!)),
          ],
        ),
      ),
    );
  }

  //farklı search çeşitleri için açılan popup menu.
  PopupMenuButton searchPopupMenu() => PopupMenuButton<_MenuValues>(
        icon: Icon(LineIcons.horizontalSliders, color: Theme.of(context).iconTheme.color),
        itemBuilder: (BuildContext context) => [
          //Açılır popup menudeki itemler.
          PopupMenuItem(
            child: Row(
              children: [
                Checkbox(
                  value: category[0],
                  activeColor: Colors.black87,
                  onChanged: (_) {},
                ),
                Text('Oyun'),
              ],
            ),
            value: _MenuValues.game,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Checkbox(
                  value: category[1],
                  activeColor: Colors.black87,
                  onChanged: (_) {},
                ),
                Text('Kategori'),
              ],
            ),
            value: _MenuValues.category,
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Checkbox(
                  value: category[2],
                  activeColor: Colors.black87,
                  onChanged: (_) {},
                ),
                Text('Oyun Yapımcısı'),
              ],
            ),
            value: _MenuValues.gameMaker,
          ),
          PopupMenuItem(
            height: 10,
            enabled: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(),
                Text('Sırala'),
                Divider(),
              ],
            ),
          ),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('A-Z'),
                Checkbox(
                  value: category[3],
                  activeColor: Colors.black87,
                  onChanged: (_) {},
                ),
                Text('|'),
                Checkbox(
                  value: !category[3],
                  activeColor: Colors.black87,
                  onChanged: (_) {},
                ),
                Text('Z-A'),
              ],
            ),
            value: _MenuValues.ascdesc,
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case _MenuValues.game:
              userSelect = 'gameName';
              setState(() {
                category[0] = true;
                category[1] = false;
                category[2] = false;
              });

              break;
            case _MenuValues.category:
              userSelect = 'gameCategory';
              setState(() {
                category[1] = true;
                category[0] = false;
                category[2] = false;
              });

              break;
            case _MenuValues.gameMaker:
              userSelect = 'gameMakerName';
              setState(() {
                category[2] = true;
                category[0] = false;
                category[1] = false;
              });
              break;
            case _MenuValues.ascdesc:
              setState(() {
                category[3] = !category[3];
              });
              break;
          }
        },
      );
}
