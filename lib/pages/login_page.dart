import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/services/user_preferences.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';

import 'navigation_page.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/routeLoginPage';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool? _passwordVisible, _remember;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = true;
    _remember = UserPreferences.getRemember() ?? false;
    _emailController.text = UserPreferences.getUserEmail() ?? '';
    _passwordController.text = UserPreferences.getUserPassword() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 24.0),
            child: MySingleChildScrollView(
              Axis.vertical,
              Column(
                children: [
                  Material(
                    elevation: 12.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      maxRadius: 48.0,
                      minRadius: 48.0,
                      backgroundImage: AssetImage('assets/images/user_avatars/male_avatar.png'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    //initialValue: widget.email,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(Icons.email_rounded, color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _passwordVisible!,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Şifre',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(Icons.lock_rounded, color: Colors.black),
                      suffixIcon: IconButton(
                        icon:
                            Icon(_passwordVisible! ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible!;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.black,
                            value: _remember,
                            onChanged: (bool? value) {
                              setState(() {
                                _remember = value!;
                                value == true ? UserPreferences.setRemember(true) : UserPreferences.clear();
                              });
                            },
                          ),
                          Text(
                            'Beni Hatırla!',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text('|'),
                      GestureDetector(
                        onTap: () async {
                          await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
                        },
                        child: Text(
                          'Şifrenizi mi unuttunuz?',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: GestureDetector(
                      onTap: () async {
                        SnackBar snackBar(String text) => SnackBar(
                              content: Center(
                                heightFactor: 1,
                                child: text == 'Başarılı Giriş'
                                    ? Text(
                                        'Giriş başarılı. Hoşgeldiniz..',
                                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                      )
                                    : Text(
                                        'Email veya şifte hatalı!. Lütfen tekrar giriş yapınız.',
                                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                      ),
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                            );

                        try {
                          await _auth.signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          if (_remember!) {
                            UserPreferences.setUserEmail(_emailController.text.trim());
                            UserPreferences.setUserPassword(_passwordController.text.trim());
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar('Başarısız Giriş'));
                        }

                        if (_auth.currentUser != null) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar('Başarılı Giriş'));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigationPage(
                                userID: _auth.currentUser!.uid.toString(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.cyan.shade100,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
