import 'package:flutter/material.dart';
import 'package:kgamepedia/services/firebase_firestore_helper.dart';
import 'package:kgamepedia/widgets/my_appbars.dart';
import 'package:kgamepedia/widgets/my_behavior.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../models/user.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBarB(context, 'grafikler'),
        body: Center(
          child: MySingleChildScrollView(
            Axis.vertical,
            StreamBuilder<List<KgameUser>>(
              stream: FirebaseUserHelper.readUsers(),
              builder: (context, snapshot) => buildCharts(snapshot),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCharts(AsyncSnapshot<List<KgameUser>> snapshot) {
    if (snapshot.hasData) {
      final List<String> cityList = [for (KgameUser user in snapshot.data!) user.userCity];
      final List<String> countryList = [for (KgameUser user in snapshot.data!) user.userCountry];
      final Map cityMap = {for (String cityName in cityList) cityName: 0.0};
      final Map countryMap = {for (String countryName in countryList) countryName: 0.0};
      for (String cityName in cityList) {
        cityMap.containsKey(cityName) ? cityMap[cityName]++ : cityMap[cityName] = 1;
      }
      for (String countryName in countryList) {
        countryMap.containsKey(countryName) ? countryMap[countryName]++ : countryMap[countryName] = 1;
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Kayıtlı ${snapshot.data!.length} kullanıcı bulunuyor',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 32.0),
            PieChart(
              dataMap: Map.from(cityMap),
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "ŞEHİR",
              centerTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
              legendOptions: LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(fontWeight: FontWeight.w500),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 0,
                chartValueStyle: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 32.0),
            PieChart(
              dataMap: Map.from(countryMap),
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              //  chartRadius: MediaQuery.of(context).size.width / 2.2,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "ÜLKE",
              centerTextStyle: TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
              legendOptions: LegendOptions(
                showLegendsInRow: true,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(fontWeight: FontWeight.w500),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 0,
                chartValueStyle: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    } else {
      return CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.black,
      );
    }
  }
}
