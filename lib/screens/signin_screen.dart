import 'package:flutter/material.dart';
import 'package:kgamepedia/screens/login_screen.dart';

class SignInPage extends StatefulWidget {
  static String routeName = '/routeSigninPage';

  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? _email, _password;
  bool? _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: GestureDetector(
            onLongPress: () {
              Navigator.pop(context);
            },
            child: Stack(
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
                                  'KAYIT OL',
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
                                  backgroundImage: AssetImage('assets/images/user_avatars/female_avatar.png'),
                                  backgroundColor: Color(0xFFbfecfe),
                                ),
                              ),
                              SizedBox(height: 24.0),
                              TextFormField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                initialValue: _email,
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
                                  helperText: "Email 'örnek@kgamepedia.com' formatında olmalıdır!",
                                  helperStyle: TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                },
                              ),
                              SizedBox(height: 24.0),
                              TextFormField(
                                obscureText: _passwordVisible!,
                                cursorColor: Colors.black,
                                initialValue: _password,
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
                                  helperText: 'Şifre minimum 6 karakter içermelidir!',
                                  helperStyle: TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                onChanged: (value) {
                                  setState(() {
                                    _password = value.trim();
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(_email.toString())) {
                                      if (_password.toString().length > 5) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LoginPage.ep(
                                                      _email.toString(),
                                                      _password.toString(),
                                                    )));
                                      } else {
                                        print('Şifre en az 6 karakter içermelidir!');
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
                                        'Kayıt Ol',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  'Geri dönmek için ekrana basılı tut.',
                                  style: TextStyle(color: Colors.white70, fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
