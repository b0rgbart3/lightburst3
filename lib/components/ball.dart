import 'package:flutter/material.dart';
import 'box.dart';
// import 'dart:math';
import '../model/sequence.dart';
import 'dart:developer' as developer;
import '../pages/gamewon.dart';
import '../classes/notifications.dart';
import '../model/settings.dart';

class Ball extends StatefulWidget {
  const Ball({required Key key, required this.screenWidth, required this.sliderID, 
    required this.min, required this.max, required this.current}) : super(key: key);
  final double screenWidth;
  final String sliderID;
  final int min,max, current;

  @override
  State createState() => BallState();
}

class BallState extends State<Ball> {

  late int myIntValue;
  double ballWidth = 50.0;
  late double range;
  bool tracking = false;
  late double myX;
  late double origin;

@override
void initState() {
  super.initState();
  range = (widget.max - widget.min).toDouble();
  myIntValue = widget.current;

  var valueWidth = widget.screenWidth / range;
  myX = (myIntValue - widget.min) * valueWidth;
  origin = myX;

  
 
}
  

  @override
  Widget build(BuildContext context) {
      Settings mySettings = Settings();
  

  void pressDown(details) {
 
    setState(() {
      tracking = true;
      origin = myX;
    });
  }

  void longPress(details) {
    setState(() {
      tracking = true;
      origin = myX;
      

       myX = origin + details.localPosition.dx;
      if (myX > ( widget.screenWidth)) {
        myX = widget.screenWidth;
      }
      if (myX < 0.0) {
        myX = 0.0;
      }

      myIntValue = (myX / range).round();

    });
  }
  void letUp(details) {
   
    DragNotification(id:widget.sliderID, value: myIntValue, drop: true)
      ..dispatch(context);
  }
  void trackMe(details) {
  
    setState(() {

      myX = origin + details.localPosition.dx;
      if (myX > ( widget.screenWidth)) {
        myX = widget.screenWidth;
      }
      if (myX < 0.0) {
        myX = 0.0;
      }

      var myPos = range * (myX/widget.screenWidth) + widget.min;
      
     
      myIntValue = myPos.round();
    });
        DragNotification(id:widget.sliderID, value: myIntValue, drop:false)
      ..dispatch(context);
  }
  void tapCancel() {

  }



    return Transform.translate(
      offset: Offset(myX,0.0),
      child:Padding(
      padding:EdgeInsets.only(top:41.0, left: 6.0, right:6.0),
      child: GestureDetector(
        onHorizontalDragStart: pressDown,
        onHorizontalDragEnd: letUp,
        onHorizontalDragUpdate: trackMe,
        onTapCancel: tapCancel,
        child: Stack(
          alignment: Alignment.center,
          children:[Container(
      height:49,
      width:ballWidth*1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:mySettings.myColorSet.shadow 
      )
    ),
    Container(
      height:38,
      width:ballWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:mySettings.myColorSet.insideHi 
      )
    )]
    )
    )
    )
    );
  }

}
