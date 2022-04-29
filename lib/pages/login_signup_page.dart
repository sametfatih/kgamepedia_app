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
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.only(top: 9.0, bottom: 9.0, left: 36.0, right: 36.0),
                    child: ClipRect(
                      child: Image.asset(
                        'assets/images/logos/kgames.png',
                      ),
                    )

                    // Text(
                    //   'KGAMES',
                    //   style: TextStyle(color: Color(0xFF212121), fontSize: 32, fontWeight: FontWeight.bold),
                    // ),
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(80),
                    child: TabBar(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xfff14b2c),
                        indicator: RectangularIndicator(
                          color: Color(0xfff14b2c),
                          bottomLeftRadius: 80,
                          bottomRightRadius: 80,
                          topLeftRadius: 80,
                          topRightRadius: 80,
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
                        ]),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: TabBarView(children: [
                    LoginPage(),
                    SignUpPage(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
