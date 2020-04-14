import 'package:flutter/material.dart';

import '../constants.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({
    @required this.currentTimeSeconds,
    this.isCountingDown,
  });

  final int currentTimeSeconds;
  final bool isCountingDown;
  Widget selectionTimeDisplay() {
    return Column(
      children: <Widget>[
        Text(
          (currentTimeSeconds / 60).floor().toString(),
          style: kMinuteTextStyle,
        ),
        Text('minutes'),
      ],
    );
  }

  Widget activeTimeDisplay() {
    var minutesTime =
        (currentTimeSeconds / 60).floor().toString().padLeft(2, '0');
    var secondsTime = (currentTimeSeconds % 60).toString().padLeft(2, '0');
    return Column(
      children: <Widget>[
        Text(
          '$minutesTime:$secondsTime',
          style: kMinuteTextStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isCountingDown) {
      return activeTimeDisplay();
    } else {
      return selectionTimeDisplay();
    }
  }
}
