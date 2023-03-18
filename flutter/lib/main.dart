import 'package:flutter/material.dart';
import 'pages/gameplay.dart';
import 'pages/gamewon.dart';
import 'pages/info.dart';
import 'pages/welcome.dart';

// LIGHTBURST
// (c) Copyright 2020 by Bart Dority
//
//
// This game and the related code are 
// copyrighted (c) by Bart Dority, 2021,
//  all rights are reserved.  

// Please contact bartdority@gmail.com 
// if you would like to use any part 
// of the code or game design.  Thank you.
// 


// Kick off the application
void main() {
  runApp(const LightBurst());
}

// We start with a stateless widget - that
// launches a "Material App" -- and displays
// Welcome as our "homepage".

class LightBurst extends StatelessWidget {
  const LightBurst({super.key});

  // This widget is the root of the application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'LightBurst',
  //     theme: ThemeData(
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     home: Welcome(key: const Key('Welcome'),),
  //   );
  // }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LightBurst',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
        routes: {
          '/': (context) => Welcome(key: const Key('Welcome'),),
          
        },
        initialRoute: '/',
        );
  }

}