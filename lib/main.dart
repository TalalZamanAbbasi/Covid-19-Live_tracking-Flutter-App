import 'package:covidapp/screens/world_stats.dart';
import 'package:covidapp/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_)=> ThemeChanger(),
      child: Builder(
        builder: (BuildContext context){
          var themeChanger=Provider.of<ThemeChanger>(context);
          return MaterialApp(
            themeMode: themeChanger.themeMode,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.deepOrange,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepOrange,

            ),
            home: WorldStats(),
          );
        },
      )
    );







    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.dark(),
    //   home: WorldStats(),
    // );
  }
}
