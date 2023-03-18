
import 'package:flutter/material.dart';
import '../components/interface.dart';
import '../components/navbutton.dart';
import '../model/settings.dart';
import '../components/framer.dart';

class GameWon extends StatelessWidget {
  const GameWon({super.key});
 
@override
  Widget build(BuildContext context) {
      Settings mySettings = Settings();
      double duration = mySettings.getDuration;
      double score = mySettings.score - (duration*5.0);
      if (score < 0.0) {
        score = 0;
      }
        void newGame()  {
  Navigator.pop(context);
  }

  if (duration < 1) {
    duration = 1;
  }

    String finishedText = "You finished in " + duration.toStringAsFixed(0);

    if (duration > 1) {
      finishedText = finishedText + " seconds.";
    } else {
      finishedText = finishedText + " second.";
    }
    return Framer(
          Column( children: [TitleText(""),
            TitleText("YOU WON!"),
          boxText(finishedText, Colors.white, Colors.black),
         
          boxText("SCORE:  " + score.toStringAsFixed(0), Colors.white, Colors.black),
          boxText(" ", Colors.white, Colors.black),
          
          NavButton(
            UniqueKey(), newGame,"PLAY AGAIN", null, 300, 60, false, false),

          ]
          )
    );
  }

}
