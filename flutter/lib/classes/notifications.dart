

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PlayNotification extends Notification {
  final Object id;

  const PlayNotification({required this.id});
}


class DragNotification extends Notification {
  final Object id;
  int value;
  bool drop;

  // Need to Add Settings Value to this notification object

  DragNotification({required this.id, required this.value, required this.drop});
}


class TouchNotification extends Notification {
  final Object myID;

  const TouchNotification({required this.myID});
}

class ChangeNotification extends Notification {
  final Object myID;

  const ChangeNotification({required this.myID});
}

class TimerEndNotification extends Notification {
  final Object myID;

  const TimerEndNotification({required this.myID});
}