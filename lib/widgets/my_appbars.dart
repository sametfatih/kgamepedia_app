import 'package:kgamepedia/screens/creator_screen.dart';
import 'package:flutter/material.dart';

AppBar myAppBar(BuildContext context, String title) => AppBar(
      toolbarHeight: 48,
      elevation: 0.2,
      backgroundColor: Colors.white,
      centerTitle: true,
      leadingWidth: 65,
      leading: title == 'KGAMEPEDIA'
          ? GestureDetector(
              onDoubleTap: () {
                Navigator.pushNamed(context, CreatorPage.routeName);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 16, top: 5, bottom: 5),
                  child: Image.asset(
                    'assets/images/logos/kgame_logo.png',
                    fit: BoxFit.fill,
                  )),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        title == 'KGAMEPEDIA'
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            : Icon(null)
      ],
    );

PreferredSizeWidget myGameAppBar(BuildContext context, String title) => AppBar(
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0.2,
      backgroundColor: Colors.white,
      toolbarHeight: 48.0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
