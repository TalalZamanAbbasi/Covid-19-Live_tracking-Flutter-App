import 'dart:convert';

import 'package:covidapp/models/countries_list_model.dart';
import 'package:covidapp/screens/countries_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  List<CountriesListModel> countriesList = [];

  Future<CountriesListModel?> getWorldStats() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        setState(() {
          countriesList.add(CountriesListModel.fromJson(i));
        });
      }
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorldStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10,),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: countriesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesStats(name: countriesList[index].country.toString())));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [

                                Image(
                                  width: 50,
                                    height: 50,
                                    image: NetworkImage(countriesList[index].countryInfo!.flag.toString())
                                ),
                                SizedBox(width: 28,),
                                Text(countriesList[index].country.toString()),
                              ],
                            )
                          ],
                        ),
                      );
                    })
            )
          ],
        ),
      ),
    );
  }
}
