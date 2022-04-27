import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/models/user.dart';
import 'package:kgamepedia/utils/constants/country_and_cities.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:numberpicker/numberpicker.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = '/routeSigninPage';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _age = 18;
  bool? _passwordVisible;
  String _dropdownCountry = Constants().countrys[0];
  String _dropdownCity = Constants().cities[0];

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = true;
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 12.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          maxRadius: 48.0,
                          minRadius: 48.0,
                          backgroundImage: AssetImage('assets/images/user_avatars/female_avatar.png'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
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
                                  hintText: 'Ad',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                              Divider(color: Colors.transparent),
                              TextFormField(
                                controller: _surnameController,
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
                                  hintText: 'Soyad',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(color: Colors.transparent),
                        Expanded(
                          flex: 1,
                          child: NumberPicker(
                              minValue: 12,
                              maxValue: 100,
                              value: _age,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black),
                              ),
                              selectedTextStyle:
                                  TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                              onChanged: (val) {
                                setState(() {
                                  _age = val;
                                });
                              }),
                        ),
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
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
                        helperText: "Email 'örnek@kgamepedia.com' formatında olmalıdır!",
                        helperStyle: TextStyle(color: Colors.black54, fontSize: 10),
                      ),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    Divider(color: Colors.transparent),
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
                          icon: Icon(
                              _passwordVisible! ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible!;
                            });
                          },
                        ),
                        helperText: 'Şifre minimum 6 karakter içermelidir!',
                        helperStyle: TextStyle(color: Colors.black54, fontSize: 10),
                      ),
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    Divider(color: Colors.transparent),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            menuMaxHeight: 250,
                            isExpanded: true,
                            value: _dropdownCity,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            items: Constants().cities.map(
                              (String countrys) {
                                return DropdownMenuItem(
                                  value: countrys,
                                  child: Text(
                                    countrys,
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(
                                () {
                                  _dropdownCity = value!;
                                },
                              );
                            },
                          ),
                        ),
                        VerticalDivider(color: Colors.transparent),
                        Expanded(
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            menuMaxHeight: 250,
                            isExpanded: true,
                            value: _dropdownCountry,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                            items: Constants().countrys.map(
                              (String countrys) {
                                return DropdownMenuItem(
                                  value: countrys,
                                  child: Text(
                                    countrys,
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(
                                () {
                                  _dropdownCountry = value!;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: GestureDetector(
                        onTap: () async {
                          SnackBar snackBar(String text, String message) => SnackBar(
                                content: Center(
                                  heightFactor: 1,
                                  child: text == 'Başarılı'
                                      ? Text(
                                          'Kayıt Başarılı.',
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          message,
                                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                        ),
                                ),
                                backgroundColor: Colors.white,
                                elevation: 0,
                              );

                          try {
                            if (_nameController.text.length > 2 && _surnameController.text.length > 2) {
                              // if (RegExp("\b([A-Z][a-z]+[ ]*)+").hasMatch(_nameController.text) &&
                              //     RegExp("\b([A-Z][a-z]+[ ]*)+").hasMatch(_surnameController.text))

                              if (true) {
                                await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                                await _auth.signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                                final user = KgameUser(
                                  userName: _nameController.text.trim(),
                                  userSurname: _surnameController.text.trim(),
                                  userAge: _age,
                                  userEmail: _emailController.text.trim(),
                                  userPassword: _passwordController.text.trim(),
                                  userCountry: _dropdownCountry.trim(),
                                  userCity: _dropdownCity.trim(),
                                  userLikes: [],
                                );
                                await createUser(user, _auth.currentUser!.uid);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar('Hata', 'Ad ve soyad sadece harflerden oluşmalıdır.'));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar('Hata', 'Ad ve soyad minimum üç karakterden oluşmalıdır.'));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar('Hata', 'Kayıt başarısız!. Lütfen tekrar kayıt olunuz.'));
                          }

                          if (_auth.currentUser != null) {
                            await _auth.signOut();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar('Başarılı', 'Kayıt Başarılı.'));
                          }
                        },
                        child: Material(
                          elevation: 6.0,
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.cyan.shade100,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 72.0, vertical: 16.0),
                            child: Text(
                              'Kayıt Ol',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future createUser(KgameUser user, String userID) async {
    DocumentReference docUser = FirebaseFirestore.instance.collection('users').doc(userID);
    user.id = docUser.id;
    final userJson = user.toJson();
    await docUser.set(userJson);
  }
}
