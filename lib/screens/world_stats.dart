import 'dart:convert';
import 'package:covidapp/components/reusable_row.dart';
import 'package:covidapp/models/world_stats_model.dart';
import 'package:covidapp/screens/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:covidapp/theme_changer.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  _WorldStatsState createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> {
  Future<WorldStatsModel?> getWorldStats() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      return WorldStatsModel.fromJson(data);
    } else {
      return WorldStatsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 230,
                    height: 100,
                    child: Text(
                      'COVID-19 Live World Stats',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        fontStyle: FontStyle.italic,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder<WorldStatsModel?>(
                  future: getWorldStats(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: 240,
                        width: 200,
                        child: Center(child: Text("Data Loading...")),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(08.0),
                          child: Column(
                            children: [
                              MyReusableRow(
                                title: 'Total Deaths',
                                value: snapshot.data!.deaths.toString(),
                              ),
                              MyReusableRow(
                                title: 'Today Cases',
                                value: snapshot.data!.todayCases.toString(),
                              ),
                              MyReusableRow(
                                title: 'Today Deaths',
                                value: snapshot.data!.todayDeaths.toString(),
                              ),
                              MyReusableRow(
                                title: 'Today Recovered',
                                value: snapshot.data!.todayRecovered.toString(),
                              ),
                              MyReusableRow(
                                title: 'Total Active',
                                value: snapshot.data!.active.toString(),
                              ),
                              MyReusableRow(
                                title: 'Total Critical Now',
                                value: snapshot.data!.critical.toString(),
                              ),
                            ],
                          ),
                        )),
                      );
                    }
                  }),
              Material(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  height: 50,
                  color: Colors.teal,
                  minWidth: double.infinity,
                  child: Text('Countries Tracker'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountriesList()));
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Container(
                    width: 230,
                    height: 30,
                    child: Text(
                      'Select One of your Choice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  RadioListTile(
                    title: Text('Light Theme'),
                    value: ThemeMode.light,
                    groupValue: themeChanger.themeMode,
                    onChanged: themeChanger.setTheme,
                  ),
                  RadioListTile(
                    title: Text('Dark Theme'),
                    value: ThemeMode.dark,
                    groupValue: themeChanger.themeMode,
                    onChanged: themeChanger.setTheme,
                  ),
                  RadioListTile(
                    title: Text('System Theme'),
                    value: ThemeMode.system,
                    groupValue: themeChanger.themeMode,
                    onChanged: themeChanger.setTheme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
