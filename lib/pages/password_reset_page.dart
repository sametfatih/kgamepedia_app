import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';

class PasswordsReset extends StatelessWidget {
  PasswordsReset({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarB(context, 'şifremi unuttum'),
        body: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Lütfen şifresini değiştirmek istediğiniz hesabınızın email adresini aşağıya yazınız.'),
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
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
              ElevatedButton(
                style:
                    ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Girdiğiniz mail adresine ait bir hesap bulunamadı. Kontrol edip tekrar deneyiniz.')));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Şifre sıfırlama mesajı email adresinize gönderildi.')));
                },
                child: Text('Şifre yenileme E-postası gönder'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
