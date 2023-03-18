/// Flutter code sample for RotationTransition

// The following code implements the [RotationTransition] as seen in the video
// above:

import 'package:flutter/material.dart';


/// This is the stateful widget that the main application instantiates.
class Rotator extends StatefulWidget {
  Widget tofu;
  Rotator({required Key key, required this.tofu}) : super(key: key);

  @override
  _RotatorState createState() => _RotatorState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _RotatorState extends State<Rotator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    var tofu = widget.tofu;
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: tofu,
          ),
        ),
      ),
    );
  }
}
