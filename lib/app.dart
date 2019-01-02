import 'package:flutter/material.dart';
import 'package:mquote/home.dart';
import 'package:mquote/util/db.dart';

class MQuoteApp extends StatelessWidget {
  Widget build(BuildContext context) {
    Db dbHelper = Db();
    dbHelper.initializeDb();

    return MaterialApp(
      title: 'MQuote',
      theme: new ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        // Define the default Font Family
        fontFamily: 'Oxygen',
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'Oxygen'),
          title: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              fontFamily: 'Oxygen'),
          body1: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'Oxygen',
            color: Colors.white70,
          ),
          body2: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'Oxygen',
            color: Colors.white54,
          ),
        ),
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
