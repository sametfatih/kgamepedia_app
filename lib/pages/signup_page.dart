import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
              child: MySingleChildScrollView(
                Axis.vertical,
                Column(
                  children: [
                    //avatar
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 6.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          maxRadius: 48.0,
                          minRadius: 48.0,
                          backgroundImage: AssetImage('assets/images/user_avatars/male_avatar.png'),
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        //ad soyad
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Material(
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(8.0),
                                child: TextFormField(
                                  controller: _nameController,
                                  cursorColor: Colors.black54,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.black54)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.black54)),
                                    hintText: 'Ad',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                              ),
                              Divider(color: Colors.transparent),
                              Material(
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(8.0),
                                child: TextFormField(
                                  controller: _surnameController,
                                  cursorColor: Colors.black54,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.black54)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.black54)),
                                    hintText: 'Soyad',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(color: Colors.transparent),
                        //yaş
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
                    //email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(8.0),
                          child: TextFormField(
                            controller: _emailController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black54)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black54)),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: Icon(Icons.email_rounded, color: Theme.of(context).iconTheme.color),
                            ),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                          child: Text("Email 'örnek@kgamepedia.com' formatında olmalıdır!",
                              style: TextStyle(color: Colors.black54, fontSize: 10)),
                        ),
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    //Şifre
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(8.0),
                          child: TextFormField(
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
                              prefixIcon: Icon(Icons.lock_rounded, color: Theme.of(context).iconTheme.color),
                              suffixIcon: IconButton(
                                icon: Icon(_passwordVisible!
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded),
                                color: Theme.of(context).iconTheme.color,
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible!;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                          child: Text('Şifre minimum 6 karakter içermelidir!',
                              style: TextStyle(color: Colors.black54, fontSize: 10)),
                        ),
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    //şehir, ülke
                    Row(
                      children: [
                        //şehir
                        Expanded(
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(8.0),
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
                        ),
                        VerticalDivider(color: Colors.transparent),
                        //ülke
                        Expanded(
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(8.0),
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
                        ),
                      ],
                    ),
                    //kayıt ol
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: MaterialButton(
                        onPressed: () async {
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
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                elevation: 0,
                              );

                          try {
                            if (_nameController.text.length > 2 && _surnameController.text.length > 2) {
                              if (RegExp(r"^\s*[A-Za-z]{3}[^\n\d]*$").hasMatch(_nameController.text) &&
                                  RegExp(r"^\s*[A-Za-z]{3}[^\n\d]*$").hasMatch(_surnameController.text)) {
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
                                  userLibrary: [],
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
                            _emailController.clear();
                            _passwordController.clear();
                            _nameController.clear();
                            _surnameController.clear();
                          }
                        },
                        child: Material(
                          elevation: 6.0,
                          borderRadius: BorderRadius.circular(8.0),
                          color: Theme.of(context).primaryColor,
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
