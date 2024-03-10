import 'package:flutter/material.dart';
import 'package:zikirmatik/homepageScreen/homepage.dart';

/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dua ve Zikir Yöneticisi',
      theme: ThemeData(
        brightness: Brightness.light, // Light mode
        primarySwatch: Colors.green,
        primaryColor: Colors.white,
        hintColor: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark mode
        primarySwatch: Colors.green,
        primaryColor: Colors.black,
        hintColor: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            debugShowCheckedModeBanner: false,
            title: 'Kindacode.com',
            theme: ThemeData(
                //butoon text color green

                //  <-- dark color),
                ),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: HomePage(),
          );
        });
  }
}
