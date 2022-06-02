
import 'package:demoproject/profile.dart';
import 'package:flutter/material.dart';

import 'add_user_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Demo App",
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProfilePage(),
    );
  }
}


