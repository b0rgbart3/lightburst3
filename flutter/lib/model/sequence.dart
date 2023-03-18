import 'dart:math';
import 'settings.dart';
import 'dart:developer' as developer;

class Sequence {
  int sequenceLength;
  final tileCount;

  List sequenceObjects = [];  // RANDOM ID OBJECTS
  List sequenceIndexes = [];  // THE INDEX #'s of the touches
  // The board is an array of true and false values
  // for on or off tiles
  List board = []; 
  List hitList = [];

  Sequence(this.sequenceLength, this.tileCount) {
    generateRandomSequence();
  }

  void fresh() {
    sequenceObjects = [];
    sequenceIndexes = [];
    board = [];
  }
  bool reveal(index) {
    return (sequenceIndexes.indexOf(index) != -1);
  }

void toggleBoard(index) {
  if ((board != null ) && (board[index] != null)) {
    if (board[index] == true) {
      board[index] = false;
    } else {
      board[index] = true;
    }
  }
}

void generateRandomSequence() {
  if (sequenceLength > (tileCount*tileCount)) {
    sequenceLength = (tileCount*tileCount) -1;
  }
    for (var i = 0; i < sequenceLength; i++) {
      var rn = new Random();
      var _randomRow = rn.nextInt(tileCount);
      var _randomCol = rn.nextInt(tileCount);
      var _randomID = {"row": _randomRow, "col": _randomCol};
      var _associatedIndex = _randomRow*tileCount + _randomCol;
      
      // If this index is not already in our list, then we can add it to our list
      // This is because if the tile was touched twice that is the same
      // as not touching it at all -- so we only want to include it in our
      // touched list if it has been hit an "odd" number of times.
      
      if (sequenceIndexes.indexOf(_associatedIndex) == -1) {
        sequenceObjects.add(_randomID);
        sequenceIndexes.add(_associatedIndex);
      } else {
        i = i-1;  // make sure we add another one to make up for the duplicate.
      }
    }
    generateBoard();

  }

bool touchBoard(idObject, tileIndex, generator) {
  bool goodChoice = false;

  toggleBoard(tileIndex);

// only add this to the hit list if it was user generated - not code generated

  if (generator == false) {
      var indexOfHit = hitList.indexOf(tileIndex);
      developer.log("indexOfHit: " + indexOfHit.toString());
  if ((indexOfHit == -1)) {
    hitList.add(tileIndex);

  } else {
    hitList.removeAt(indexOfHit);
  }
  goodChoice = checkForRemovals(idObject);
  developer.log("hit list: " + hitList.toString());
  developer.log("sequence indexes: " + sequenceIndexes.toString());
  if (sequenceIndexes.length < 1) {
    developer.log('game won -- time to dispatch?');

  }

  }

// above
  if (idObject["row"] > 0) {
    var aboveIndex = ((idObject["row"] - 1 ) * tileCount) + (idObject["col"]);
    toggleBoard(aboveIndex);
  }
// below
  if (idObject["row"] + 1 < tileCount) {

    var belowIndex = ((idObject["row"] + 1 ) * tileCount) + (idObject["col"]);
    toggleBoard(belowIndex);
  }

// left
  if (idObject["col"] > 0) {
    var leftIndex = (idObject["row"] * tileCount) + (idObject["col"]-1);
    toggleBoard(leftIndex);
  }
  // right
  if (idObject["col"]+1 < tileCount) {
    var rightIndex = (idObject["row"] * tileCount) + (idObject["col"]+1);
    toggleBoard(rightIndex);
  }
  return goodChoice;
}

void generateBoard() {
  for (var i = 0; i < tileCount * tileCount; i++) {
    board.add(false);
  }

  sequenceObjects.forEach( (idObject) {
      var row = idObject["row"];
      var col = idObject["col"];
      var tileIndex = row*tileCount + col;
                                      // generator vs. human
      touchBoard(idObject, tileIndex, true);
  });
}
// When a tile gets touched, we check to see if it's in the full sequence
// and if not, then we need to add it to the full sequence (weather its on or off)
  int updateSequence( tileID ) {
    var row = tileID["row"];
  
    var col = tileID["col"];
    var tileIndex = row*tileCount + col;

    //developer.log("updating sequence:" + row.toString() + ", " + col.toString());
    // developer.log(touches.toString());
    final found = sequenceIndexes.indexWhere((element) =>
        element == tileIndex);
   // developer.log("found: " + found.toString());

    if (found == -1) {
      // then this touch is not in our sequence, so we need to add it to the sequence
      // this is because the user is now making their life harder than it needs to be
      // by selecting a tile that is not in the sequence.

      sequenceObjects.add(tileID);
      sequenceIndexes.add(tileIndex);
      //developer.log("Not found: " + found.toString());
    } 

 

    return found;
  }

// When an adjacent tile is turned off, let's 
  



int findYourOwnDamnObject( needle, haystack ) {

    var row = needle["row"];
    var col = needle["col"];

    for (var i = 0; i < haystack.length; i++) {
      if ((haystack[i]["row"] == row) && (haystack[i]["col"] == col)) {
        return i;
      }
    }

   return -1;
}

bool checkForRemovals(tileID) {
     var row = tileID["row"];
  
    var col = tileID["col"];

  var index = findYourOwnDamnObject(tileID, sequenceObjects);
    var tileIndex = row*tileCount + col;

  if (index != null && index != -1) {
  sequenceObjects.removeAt(index);
  sequenceIndexes.remove(tileIndex);

  } else {
    sequenceIndexes.add(tileIndex);
    sequenceObjects.add(tileID);
    return false;
  }


   return true;


    }
      
}