import 'package:flutter/material.dart';
import 'package:kgamepedia/services/user_preferences.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  late bool switchVal = UserPreferences.getTheme() == 'red' ? false : true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: myAppBarB(context, 'uygulama ayarları'),
        body: Center(
          child: Column(
            children: [
              Text(
                'TEMA',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Transform.scale(
                  scale: 2.0,
                  child: Switch(
                    activeColor: Colors.teal.shade200,
                    activeTrackColor: Colors.teal.shade200,
                    inactiveThumbColor: Color(0xfff14b2c),
                    inactiveTrackColor: Color(0xfff14b2c),
                    value: switchVal,
                    onChanged: (value) {
                      setState(
                        () {
                          switchVal = value;
                          if (value == false) {
                            UserPreferences.setTheme('red');
                          } else {
                            UserPreferences.setTheme('teal');
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              Text(
                'Uygulamayı yeniden başlatmanız gerekiyor.',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
