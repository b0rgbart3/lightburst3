import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';
import '../classes/notifications.dart';
import '../pages/gameplay.dart';
import '../components/tile.dart';
import '../components/framer.dart';
import '../components/interface.dart';

// This is our Welcome / home page
// it displays the cross hairs of tiles with the play
// button in the middle.  This acts sort of like a splash
// logo intro screen.  Note: the game doesn't start until
// the user clicks "play" -- this is a psychological device
// to put the user in the mindset to enjoy the game.

// Note: this welcome screen uses "tiles" instead of boxes
// which means there is some duplication between the Box
// component and the 'tile' component -- but for now I still
// have both because I wanted to display the word "play" in
// the middle of the middle tile and have it scale appropriately
// but for most of the rest of the game there is no text
// so the rest of the game uses the 'box' component.  

// I would like to refactor this welcome screen to also use
// the box component instead of the tile component, but for
// now this is the way it is coded.

class Welcome extends StatefulWidget {
  Welcome({required Key key}) : super(key: key);
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  List _tiles=[];
  List _keys = [];

  // this is our main Settins Object (a singleton) - which I am
  // using as the App's "Global State".
  
  Settings _mySettings = Settings();

  // We go into this method if the user clicks the 'back' button 
  // on the game screen.
  // We don't instantiate a new game - it's just a nicety
  // to be able to go back to the welcome screen in a benign way

  void _backInWelcome( settingsGotChanged ) {
        _keys.asMap().forEach( (index, key) => {
          if (index == 2) {
          if (key.currentState != null) {
            key.currentState.turnOn()
          }
          } else {
          if (key.currentState != null) {
            key.currentState.turnOff()
          }}
          });
      // If the user changed the color in the settings page,
      // then we need to update things here.
      if (settingsGotChanged) {
        setState(() {
        });
      }
  }

  // Here the user clicked the play button so let's start
  // the game by launching the GamePlay page
  void _aboutToPlay(context) async {
    _keys.forEach( (key) => {
      if (key.currentState != null) {
        key.currentState.turnOn() }
        } );

    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => Game(key: const Key('Game'))))
    .then((value) => _backInWelcome(value)
       );
  }

  // We build the tiles for the welcome screen and keep track of their _keys
  // so that we can programmatically turn the tiles on and off.

  void _buildTiles() {

    double mySize = _mySettings.screenSize / 3.75;
    //developer.log("My size should be: " + mySize.toString());

    Key key0 = GlobalKey();
    _tiles.add( Tile( key0, mySize, 0, "", false, false ) );
    Key key1 = GlobalKey();
    _tiles.add( Tile( key1, mySize, 1, "", false, false ) );
    Key key2 = GlobalKey();
    _tiles.add( Tile( key2, mySize, 2, "Play", true, true ) );
    Key key3 = GlobalKey();
    _tiles.add( Tile( key3, mySize, 3, "", false, false ) );
    Key key4 = GlobalKey();
    _tiles.add( Tile( key4, mySize, 4, "", false, false) );

    _keys.add(key0);
    _keys.add(key1);
    _keys.add(key2);
    _keys.add(key3);
    _keys.add(key4);
  }

  // This widget sets up all of the tiles into a Column
  // that animates from 0 to it's full size in 300 ms

  Widget _animatedCross() {
    double endSize = 1.0;
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: endSize),
                duration: Duration(milliseconds: 300),
                builder: (_, double myWidth, __) {
            return Transform.scale(
              scale: myWidth,
              child: 
                Column( mainAxisAlignment: MainAxisAlignment.center,
                children:[
                      _tiles[0],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_tiles[1],_tiles[2],_tiles[3],
                        ],
                      ),
                        _tiles[4],
                    ])
                  );
                }
      )  ;
  }
  

   Widget _cross() {

      return  NotificationListener<PlayNotification> (
                onNotification: (notification) {
                  // we got a notification from one of the tiles that the user is ready to play
                  _aboutToPlay(context);
                  return true;
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 70.0),
                  child: Column(children: [
                Column(
                  children: [
                  TitleText("LIGHTBURST"),
                  Container( 
                      height: _mySettings.screenSize,
                      child:  _animatedCross()
                      )
                  ],
                )])
                )
       );
    }


  // This is the main build method of the welcome screen
  @override
  Widget build(BuildContext context) {

     // keeping track of our context by sending it to our settings singleton
    _mySettings.context = context; 

    // building our tile widgets
    _buildTiles();
   
    // build the cross layout inside of our standard frame widget
    return Framer(_cross());
  }
}
