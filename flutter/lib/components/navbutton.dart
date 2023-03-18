import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'interface.dart';
import '../pages/gameplay.dart';
import '../classes/notifications.dart';
import '../classes/colorset.dart';
import '../model/settings.dart';

// This widget is my custom navigation button widget
// It produces a square button for icon navigation
// and a horizontal rectangle for text navigation

class NavButton extends StatefulWidget {
  final key, onPressed, textString, icon;
  double navWidth, navHeight;
  bool onState;
  bool toggle;

  NavButton(this.key, this.onPressed, this.textString, this.icon, this.navWidth,
      this.navHeight, this.onState, this.toggle);

  @override
  State createState() => NavButtonState();
}

class NavButtonState extends State<NavButton> {
  late double endWidth, endHeight;
  double endScale = .9;
  late bool onState;
  late double tileWidth,
      tileHeight,
      innerBoxHeightPercentage,
      innerBoxWidthPercentage;

  @override
  void initState() {
    super.initState();
    tileWidth = widget.navWidth;
    tileHeight = widget.navHeight;

    endWidth = tileWidth * .9;
    endHeight = tileHeight * .9;
    onState = widget.onState;
  

    if (widget.textString == "") {
      innerBoxWidthPercentage = .95;
      innerBoxHeightPercentage = .9;
    } else {
      innerBoxWidthPercentage = .91;
      innerBoxHeightPercentage = .88;
    }
  }

  @override
  Widget build(BuildContext context) {
  Settings mySettings = Settings();
  Colorset introColorSet = mySettings.myColorSet;

    // developer.log("in nav button: onState = " + onState.toString());
    // developer.log("this icon = " + widget.icon.toString());

    var insideColor, outsideColor, shadowColor, textColor, textShadowColor;

   // var myColor, myShadowColor, myCenterColor;

    if (onState) {

      insideColor = introColorSet.insideHi;
      outsideColor = introColorSet.outsideHi;
      shadowColor = introColorSet.shadowHi;
      textColor = introColorSet.textHi;
      textShadowColor = introColorSet.textShadowHi;
    } else {

       insideColor = introColorSet.inside;
       outsideColor = introColorSet.outside;
       shadowColor = introColorSet.shadow;
       textColor = introColorSet.text;
       textShadowColor = introColorSet.textShadow;
    }

    Widget buttonChild() {
      if (widget.textString != "") {
        return boxText(widget.textString, textColor, textShadowColor);
      } else {
        return widget.icon;
      }
    }

    return Container(
        alignment: Alignment.center,
        width: tileWidth,
        height: tileHeight,
        child: GestureDetector(
            onTapDown: pressDown,
            onTapUp: pressUp,
            onTapCancel: pressCancel,
            child: TweenAnimationBuilder(
                tween: Tween(begin: 0.9, end: endScale),
                duration: Duration(milliseconds: 40),
                builder: (_, double percentage, __) {
                  return Transform.scale( scale: percentage, child: Stack(children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        width: endWidth,
                        height: endHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: outsideColor,
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 5,
                                spreadRadius: 5),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(children: [
                        Container(
                          alignment: Alignment.center,
                          width:
                              endWidth * innerBoxWidthPercentage,
                          height:
                              endHeight * innerBoxHeightPercentage,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: insideColor,
                          ),
                        ),
                      ]),
                    ),
                    Align(alignment: Alignment.center, child: buttonChild() )
                  ]
                      //)
                      )
                      );
                })));
  }

  void pressDown(details) {
    // developer.log('press down');
    setState(() {
      // endWidth = tileWidth * .75;
      // endHeight = tileHeight * .75;
      endScale = .75;
    });
  }

  void pressCancel() {
    setState(() {
      // endWidth = tileWidth * .9;
      // endHeight = tileHeight * .9;
      endScale = .9;
    });
  }

  void pressUp(details) {
    widget.onPressed();

    setState(() {
      // endWidth = tileWidth * .9;
      // endHeight = tileHeight * .9;
      toggleMe();
      endScale = .9;
    });
  }

  void turnOn() {
    setState(() {
      onState = true;
    });
  }

  void turnOff() {
    setState(() {
      onState = false;
    });
  }

  void toggleMe() {
    setState(() {
      if (widget.toggle) {
      onState = !onState;}
      else
      {
        onState = false;
      }
     // developer.log('toggling tile');
    });
  }
}
