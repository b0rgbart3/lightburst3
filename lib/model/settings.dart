import 'dart:developer' as developer;
import 'dart:math';
import '../model/sequence.dart';
import '../classes/colorset.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../classes/notifications.dart';
// This Settings class creates a "singleton" which
// I am using as our Global State Object

class Settings  {

  int _boardSize = 5;
  late bool _boardCreated;
  int _sequenceLength = 4;
  int initialBoardSize = 5;
  int initialSequenceLength = 4;
  final int _minBoardSize = 3;
  final int _maxBoardSize = 9;
  final int _minSequenceLength = 3;
  final int _maxSequenceLength = 14;
  late double _screenSize;
  late double _screenWidth;
  late double _screenHeight;
  bool _showSequence = false;
  Sequence _sequence = Sequence(5,5);
  late Colorset _myColorSet;
  int _colorIndex = Random().nextInt(6);
  int _minColorIndex = 0;
  double _tileSize= 0;
  int _maxColorIndex = 6;
  late BuildContext _context;
  double _score = 0;
  double _point = 25*20;
  double _initialScore = 0;
  Stopwatch _stopwatch = Stopwatch();
  

  // List _sequenceIndexes = [];

  // Singleton settings object
  // static final Settings _settings = Settings._internal();
    static final Settings _settings = Settings._internal();

  // // Internal Named constructor
  Settings._internal();

  factory Settings() {
    // return the singleton object
    return _settings;
  }
  // Named Constructor could look like this:
  // Options.withColor( this.color, this.boardSize, this.sequenceLength)
  // colorset get color => color;
  //This is a "getter" for the color value
//  int get boardSize => _boardSize;

  int get minBoardSize => _minBoardSize;
  int get maxBoardSize => _maxBoardSize;
  int get colorIndex {
   
     
      // var rn = new Random();
      // int numberOfColors = Colorset.colorsets.length - 1;
      // developer.log("number of colors: "+ numberOfColors.toString());
      // var _randomColor= rn.nextInt(numberOfColors);
      // _colorIndex = new Random().nextInt(7);
      //  developer.log("generating new colorIndex: " + _colorIndex.toString());
    
    return _colorIndex;

  } 
  int get minColorIndex => _minColorIndex;

  int get minSequenceLength => _minSequenceLength;
  int get maxSequenceLength => _maxSequenceLength;

  int get maxColorIndex{
    return _maxColorIndex;
  }

double get initialScore {
  return _initialScore;
}
  double get score {
    return _score;
  }

  Sequence get sequence {
    return _sequence;
  }
  //List get sequenceIndexes => _sequenceIndexes;

  BuildContext get context {
    return _context;
  }

  void decreaseScore(demerit) {
    _score = _score-demerit;
  }

  double get tileSize {
    if (_tileSize == 0) {
      _tileSize = screenSize / _boardSize;
    }
    return _tileSize;
  }

  void freshBoardList() {
    sequence.fresh();
    _tileSize = 0;
    _score = 0;
    _sequence = Sequence(_sequenceLength, _boardSize);
     _stopwatch = Stopwatch();
     _stopwatch.start();
     _initialScore = 0;
  }

  void toggleTile( tileIndex) {
    //_boardList[index] = !_boardList[index];
    //int index = (tileID["row"] * _boardSize ) + tileID["col"];
    double rowDouble = tileIndex/_boardSize;
    int row = rowDouble.floor();
    var tileID= {"row":row ,"col":tileIndex%_boardSize};
    bool goodChoice = sequence.touchBoard(tileID, tileIndex, false);
    if (goodChoice) {
      _score = _score + _point;
    } else {
      _score = _score -(_point*2);
    }
    developer.log("toggling tile: " + tileIndex.toString());
  }

  bool get showSequence {
    return _showSequence;
  }

  int get boardSize {
    return _boardSize;
  }

  bool get boardCreated {
     _stopwatch = Stopwatch();
     _stopwatch.start();
    return _boardCreated;
  }


  //  int get sequenceLength => _sequenceLength;

  int get sequenceLength {
    _point = _sequenceLength * 20.0;
    return _sequenceLength;
  }

  Colorset get myColorSet {
    _myColorSet = Colorset(_colorIndex);
    return _myColorSet;
  }

  double get screenSize {
     _screenWidth = MediaQuery.of(context).size.width;
     _screenHeight = MediaQuery.of(context).size.height;

    _screenSize = _screenHeight *.5;

    return _screenSize;
  }

  set context( newContext ) {
    _context = newContext;
  }

  set colorIndex(newIndex) {
    _colorIndex = newIndex;
    _myColorSet = Colorset(_colorIndex);
  }

  set myColorSet(newSet) {
    _myColorSet = Colorset(newSet);
  }

  set boardSize(int newSize) {
    _boardSize = newSize;
    _sequence = new Sequence(_sequenceLength, _boardSize);
  }


  set sequenceLength(int newSequenceLength) {
    if (newSequenceLength <=maxSequenceLength && newSequenceLength >= minSequenceLength) {
      _sequenceLength = newSequenceLength;
    }
    _sequence = new Sequence(_sequenceLength, _boardSize);;
  }

  set showSequence(bool newShowSequence) {
    _showSequence = newShowSequence;
  }

  set sequence(Sequence newSequence) {
    _sequence = newSequence;
    _boardCreated = true;
  }


  set boardCreated(bool newBoardCreated) {
  
    _boardCreated = newBoardCreated;
  }



  void toggleShowSequence() {

    _showSequence = !_showSequence;

  }

  double get getDuration {
    double duration = 0;
    if (_stopwatch != null) {
    _stopwatch.stop();
    duration = _stopwatch.elapsedMilliseconds / 1000.0;
    }
    return duration;

  }
// A Collection of key value pairs
// Maps can be iterated
// String is the key
// Dynamic data type as the value
// This method will transform our Options Class into a Map so that
// we can manipulate it and transform it
// This is more useful when using SQLite (database storage)

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["boardSize"] = _boardSize;
    map["sequenceLength"] = _sequenceLength;

    return map;
  }

  // This is the reverse of the map method

  // Another NAMED CONSTRUCTOR

  Settings.fromObject(dynamic o) {
    _boardSize = o["boardSize"];
    _sequenceLength = o["sequenceLength"];
  }
  
}
