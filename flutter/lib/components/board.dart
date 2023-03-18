import 'package:flutter/material.dart';
import 'box.dart';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';
import '../classes/notifications.dart';
import '../classes/tileID.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  List tileList =[];
  List keyList=[];
  Settings mySettings = Settings();
  int sequenceLength= 25;

@override
void initState() {
    super.initState();
}
  


  void clearBoard( ) {
    tileList = [];
    keyList = [];

    sequenceLength = mySettings.sequenceLength;
     
  }
  
  // This is the main method that gets invoked when a box is touched.
  // So we need to toggle the tile, and it's neighbors, and update
  // the sequence -- because if this tile is not in the sequence,
  // then we need to add it to the sequence (the user just made it harder on 
  // themselves )

  void touchTile( tileIndex ) {
    developer.log('touched: ');
      
      String myTileString = tileIndex.toString();
      developer.log('my tile: '+ myTileString);
      mySettings.toggleTile( tileIndex);

      setState(() { });
  }


bool getCurrentState( tileID ) {
  var index = tileID['row'] * mySettings.boardSize + tileID['col'];
  return  mySettings.sequence.board[index];
}
// Returns true if the values are "new".
// If the values are the same as before, we return false

  bool setNewValues() {
    // Note: I used to pass the values in as an object coming from the
    // Notifier.
    var settingsChanged = false;


    if (sequenceLength != mySettings.sequenceLength) {
      sequenceLength = mySettings.sequenceLength;
      settingsChanged = true;
    }
    return settingsChanged;
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<TouchNotification> (
      onNotification: (notification) {
        developer.log('Got a note: ' + notification.myID.toString());
        touchTile(notification.myID);
        return false;
      },
      child:buildRows() );
  }

  Widget buildRows() {
    List<Widget> rows = [];
    for (var i = 0; i < mySettings.boardSize; i++) {
      rows.add(buildRow(i));
    }
    return Column(children: rows);
  }

  Widget buildRow(rowNum) {
    
    List<Widget> tiles = <Widget>[];

// Dynamically build a whole row of tiles
    for (var i = 0; i < mySettings.boardSize; i++) {
     var index = rowNum*mySettings.boardSize + i;
      Widget box = Box( key: Key(index.toString()), index: index);
      tiles.add(box);
      tileList.add(box);
  }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: tiles);
  }
}