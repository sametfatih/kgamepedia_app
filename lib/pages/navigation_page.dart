import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'categories_page.dart';
import 'home_page.dart';
import 'likes_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class NavigationPage extends StatefulWidget {
  static String routeName = '/routeGNavBar';
  final String userID;
  const NavigationPage({Key? key, required this.userID}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions() => <Widget>[
        HomePage(),
        CategoriesPage(),
        SearchPage(),
        LikesPage(currentUserID: widget.userID),
        ProfilePage(
          currentUserID: widget.userID,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: _widgetOptions().elementAt(_selectedIndex),
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
                    // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    icon: LineIcons.home,
                    text: 'Anasayfa',
                  ),
                  GButton(
                    // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    icon: LineIcons.icons,
                    text: 'Kategoriler',
                  ),
                  GButton(
                    // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    icon: LineIcons.search,
                    text: 'Ara',
                  ),
                  GButton(
                    icon: LineIcons.heart,
                    text: 'Beğenilenler',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profil',
                  ),
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
