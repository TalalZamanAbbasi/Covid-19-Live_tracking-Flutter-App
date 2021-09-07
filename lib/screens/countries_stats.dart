import 'dart:convert';
import 'package:covidapp/models/country_stats_model.dart';
import 'package:http/http.dart' as http;
import 'package:covidapp/models/world_stats_model.dart';
import 'package:flutter/material.dart';
import 'package:covidapp/components/reusable_row.dart';

class CountriesStats extends StatefulWidget {
  final String name;
  CountriesStats({required this.name});

  @override
  _CountriesStatsState createState() => _CountriesStatsState();
}

class _CountriesStatsState extends State<CountriesStats> {
  Future<CountryStatsModel?> getCountryStats() async {
    var response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries/'+widget.name));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      return CountryStatsModel.fromJson(data);
    } else {
      return CountryStatsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Here are Live Stats'),
            FutureBuilder<CountryStatsModel?>(
                future: getCountryStats(),
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
                                MyReusableRow(
                                  title: 'Total Tests',
                                  value: snapshot.data!.tests.toString(),
                                ),
                                MyReusableRow(
                                  title: 'Total Population',
                                  value: snapshot.data!.population.toString(),
                                ),
                                MyReusableRow(
                                  title: 'One Case Per People',
                                  value: snapshot.data!.oneCasePerPeople.toString(),
                                ),

                              ],
                            ),
                          )),
                    );
                  }
                }),
          ],

        ),
      ),

    );
  }
}
