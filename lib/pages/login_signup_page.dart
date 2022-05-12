import 'package:flutter/material.dart';
import 'package:kgamepedia/pages/login_page.dart';
import 'package:kgamepedia/pages/signup_page.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class LoginSignUp extends StatefulWidget {
  static String routeName = '/routeLoginSignUpPage';

  const LoginSignUp({Key? key}) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(top:24,bottom: 12.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: TabBar(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      labelColor: Colors.black,
                      unselectedLabelColor: Theme.of(context).primaryColor,
                      indicator: RectangularIndicator(
                        color: Theme.of(context).primaryColor,
                        bottomLeftRadius: 8,
                        bottomRightRadius: 8,
                        topLeftRadius: 8,
                        topRightRadius: 8,
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            'GİRİŞ YAP',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'KAYIT OL',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: TabBarView(
                    children: [
                      LoginPage(),
                      SignUpPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
