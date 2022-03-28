import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../screens/categories_screen.dart';
import '../screens/home_screen.dart';

class GNavBar extends StatefulWidget {
  static String routeName = '/routeGNavBar';
  const GNavBar({Key? key}) : super(key: key);

  @override
  _GNavBarState createState() => _GNavBarState();
}

class _GNavBarState extends State<GNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CategoriesPage(),
    //SearchPage(),
    //LikesPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 16,
                activeColor: Colors.black,
                iconSize: 26,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    icon: LineIcons.home,
                    text: 'Anasayfa',
                  ),
                  GButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    icon: LineIcons.icons,
                    text: 'Kategoriler',
                  ),

                  // GButton(
                  //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  //   icon: LineIcons.search,
                  //   text: 'Ara',
                  // ),
                  // GButton(
                  //   icon: LineIcons.heart,
                  //   text: 'Beğenilenler',
                  // ),
                  // GButton(
                  //   icon: LineIcons.user,
                  //   text: 'Profil',
                  // ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
