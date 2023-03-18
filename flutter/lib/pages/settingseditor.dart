import '../components/interface.dart';
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import 'package:hexcolor/hexcolor.dart';
import '../components/slider.dart';
import '../classes/notifications.dart';
import 'dart:developer' as developer;
import '../model/settings.dart';
import '../components/framer.dart';

class SettingsEditor extends StatefulWidget {
  SettingsEditor({required Key key, required this.title}) : super(key: key);
  final String title;
  @override
  State createState() => SettingsEditorState();
}

class SettingsEditorState extends State<SettingsEditor> {

// returns our settings singleton
  Settings mySettings = Settings();  
  late int boardSize;
  late int sequenceLength;
  late int colorIndex;
  late String colorName;
  int originalBoardSize = 5;
  int originalSequenceLength = 4;
  int originalColorIndex = 0;
  late int color, minColorIndex, maxColorIndex;

  void _submitSettings() {
      var changed = false;
      var changes = [];
     // originalColorIndex = mySettings.colorIndex;
      developer.log("mySettings: " + mySettings.sequenceLength.toString());

      if (mySettings.sequenceLength != originalSequenceLength) {
      mySettings.sequenceLength = sequenceLength;
      changed = true;
      changes.add( "sequence" );
      }
      if (mySettings.boardSize != originalBoardSize) {
      mySettings.boardSize = boardSize;
      changed = true;
      changes.add( "board" );
      }
      if (mySettings.colorIndex != originalColorIndex) {
        mySettings.colorIndex = colorIndex;
        changed = true;
        changes.add( "color" );
      }
      //developer.log('about to submit changes:' + changed.toString() + changes.toString());
      Navigator.pop(context, {"changed":changed, "changes": changes} );
  }

  Widget boardSizeSlider() {
    return  NotificationListener<DragNotification>(
        onNotification: (notification) {
          //developer.log('Got notified: ' +
            //  notification.value.toString());
          // update the boardSize value based on the notification
          // that is coming from the ball getting dragged by the user
          setState(() {
              boardSize = notification.value;
              mySettings.boardSize = boardSize;
          });
          return false;
          // return true;
        },
        child: boardSizeSetting());
  }

  Widget settingsBox(contents) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0x44000000),
            ),
            child: contents));
  }

  Widget boardSizeSetting() {
   // double screenWidth = MediaQuery.of(context).size.width;
   double screenWidth = mySettings.screenSize;
    return settingsBox(Container(
            child: Stack(children: [
          
          SettingsSlider(title:"BOARD SIZE",
              screenWidth: screenWidth, sliderID: "boardSize", min: mySettings.minBoardSize, max: mySettings.maxBoardSize, current: boardSize, key: Key('settings'),)
        ])));
  }

  Widget sequenceLengthSlider() {
    return NotificationListener<DragNotification>(
        onNotification: (notification) {
            // update the sequenceLength value based on the notification
            // that is coming from the ball getting dragged by the user
            developer.log('about to update sequence length');
            setState(() {
                sequenceLength = notification.value;
                developer.log('sequence length: ' + sequenceLength.toString());
            
                mySettings.sequenceLength = sequenceLength;
            });
           // return false;
             return true;
          },
        child:
      sequenceLengthSetting());
  }



  Widget sequenceLengthSetting() {

double screenWidth = mySettings.screenSize;
     return settingsBox(Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: Container(
            child: Stack(children: [
  
          SettingsSlider(title: "SEQUENCE LENGTH", 
              screenWidth: screenWidth,
              sliderID: "sequenceLength",
              min: mySettings.minSequenceLength,
              max: mySettings.maxSequenceLength, current:sequenceLength, key: Key('Sequence length'),)
        ]))));
  }

  Widget colorSlider( editor, context) {
    return NotificationListener<DragNotification>(
        onNotification: (notification) {
          developer.log('Got color change...');
            setState(() {
                colorIndex = notification.value;
               // mySettings.colorIndex = colorIndex;
               // colorName = mySettings.myColorSet.nameString;
                
                developer.log("color changed" + colorIndex.toString());
                
            });
            return true;
          },
        child: colorSetting());
  }
  
  Widget colorSetting() {

double screenWidth = mySettings.screenSize;
     return NotificationListener<DragNotification>(
        onNotification: (notification) { 
          return false;
        },
        child: settingsBox(Container(
            child: Stack(children: [
  
          SettingsSlider(title: "COLOR",
              screenWidth: screenWidth,
              sliderID: "color",
              min: mySettings.minColorIndex,
              max: mySettings.maxColorIndex, current:colorIndex, key: Key('color slider'),)
        ]))));
  }

  @override
  Widget build(BuildContext context) {

    // Grab the values from our settings object
    boardSize = mySettings.boardSize;
    sequenceLength = mySettings.sequenceLength;
    colorIndex = mySettings.colorIndex;

    if (originalBoardSize == null) {
      originalBoardSize = boardSize;
    }
    if (originalSequenceLength == null) {
      originalSequenceLength = sequenceLength;
    }

    return Framer(Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
          children: [
            TitleText("SETTINGS"),
            boardSizeSlider(),
            sequenceLengthSlider(),
            colorSlider(this, context),
            NavButton(
                null,
                _submitSettings,
                "",
                Icon(Icons.done,
                    size: 54.0, color: mySettings.myColorSet.text),
                65.0,
                65.0, false, false),
          ],
        )
        ));
    
  }
}