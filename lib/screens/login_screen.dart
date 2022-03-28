import 'package:flutter/material.dart';
import 'package:kgamepedia/main.dart';
import 'package:kgamepedia/screens/signin_screen.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/routeLoginPage';
  String? email;
  String? password;

  LoginPage({
    Key? key,
  }) : super(key: key);
  LoginPage.ep(this.email, this.password, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _passwordVisible;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  String _tempPassword = '';
  String _tempEmail = '';

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/backgrounds/blue.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(24.0),
                      color: Colors.black.withOpacity(0.66),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                'GİRİŞ',
                                style: TextStyle(
                                    color: Color(0xFFbfecfe), fontSize: 27.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Material(
                              elevation: 12.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                maxRadius: 42.0,
                                minRadius: 42.0,
                                backgroundImage: AssetImage('assets/images/user_avatars/male_avatar.png'),
                                backgroundColor: Color(0xFFbfecfe),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            TextFormField(
                              controller: _emailController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              //initialValue: widget.email,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFbfecfe),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                    borderSide: BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                    borderSide: BorderSide(color: Colors.black)),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                prefixIcon: Icon(Icons.email_rounded, color: Colors.black),
                              ),
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                              onChanged: (value) {
                                _tempEmail = value.trim();
                              },
                            ),
                            SizedBox(height: 24.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _passwordVisible!,
                              cursorColor: Colors.black,
                              //initialValue: widget.password,
                              decoration: InputDecoration(
                                fillColor: Color(0xFFbfecfe),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                    borderSide: BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                    borderSide: BorderSide(color: Colors.black)),
                                hintText: 'Şifre',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                prefixIcon: Icon(Icons.lock_rounded, color: Colors.black),
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordVisible!
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible!;
                                    });
                                  },
                                ),
                              ),
                              style: TextStyle(fontWeight: FontWeight.w400),
                              onChanged: (value) {
                                _tempPassword = value.trim();
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Şifrenizi mi unuttunuz?',
                                      style: TextStyle(
                                        color: Color(0xFFbfecfe),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(widget.email.toString())) {
                                    if (widget.email == _tempEmail && widget.password == _tempPassword) {
                                      Navigator.pushNamed(context, MyHomePage.routeName);
                                      _emailController.clear();
                                      _passwordController.clear();
                                    } else {
                                      print('Email veya şifre hatalı!');
                                    }
                                  } else {
                                    print('Email uygun formatta değil!');
                                  }
                                },
                                child: Material(
                                  elevation: 6.0,
                                  borderRadius: BorderRadius.circular(36.0),
                                  color: Color(0xFFbfecfe),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
                                    child: Text(
                                      'Giriş yap',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SignInPage.routeName);
                              },
                              child: Material(
                                elevation: 6.0,
                                borderRadius: BorderRadius.circular(36.0),
                                color: Color(0xFFbfecfe),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
                                  child: Text(
                                    'Kayıt Ol',
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
