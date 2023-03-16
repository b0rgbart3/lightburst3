import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'interface.dart';
import '../model/settings.dart';


// This widget frames all of our pages -- so that we can make sure that the
// aspect ratio is vertical even when we are on the web.
// The game was designed for mobile, so we are constraining the web version
// to have the same layout.

class Framer extends StatelessWidget {
  Framer(this.stuff);
  final Widget stuff;
  Settings mySettings = Settings();
  
  @override
  Widget build(BuildContext context) {
      return  Column ( key: UniqueKey(),
        children: [Stack(alignment: Alignment.center, children: [
          BkgImageWidget(),
          Container(
              child: Center(
              child:  Container(
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   // border: Border.all(color: mySettings.myColorSet.background ),
                  ),
                  width:mySettings.screenSize*1.1,
                  height: mySettings.screenSize*1.8, 
                  child:stuff
              ))
              )
        ])]);
}
}