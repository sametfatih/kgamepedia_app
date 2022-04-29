import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/pages/creator_page.dart';
import 'package:line_icons/line_icons.dart';

AppBar myAppBar(BuildContext context, String title) => AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      elevation: 0.2,
      backgroundColor: Colors.white,
      centerTitle: true,
      leadingWidth: 80,
      leading: title == 'KGAMES'
          ? GestureDetector(
              onDoubleTap: () {
                Navigator.pushNamed(context, CreatorPage.routeName);
              },
              child: Icon(
                LineIcons.gamepad,
                color: Colors.black,
                size: 48,
              )
              // child: Image.asset(
              //   'assets/images/logos/kgames2.png',
              //   fit: BoxFit.fitHeight,
              // ),
              )
          : null,
      title: title == 'KGAMES'
          ? Image.asset('assets/images/logos/kgames2.png', height: 60)
          : Text(
              title,
              style: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w500),
            ),
      actions: [
        title == 'KGAMES'
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
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
      toolbarHeight: 64.0,
      centerTitle: true,
      title: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
