import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/constants.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimeSelectionSlider extends StatelessWidget {
  TimeSelectionSlider({this.key, this.valueChanged, this.isAnimating});
  final Key key;
  final bool isAnimating;
  final Function valueChanged;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: kMinimumSecondsSlider.toDouble(),
      max: kMaximumSecondsSlider.toDouble(),
      initialValue: kInitialValueSeconds.toDouble(),
      innerWidget: (value) {
        return null;
      },
      appearance: CircularSliderAppearance(
        size: 250.0,
        spinnerMode: isAnimating,
        spinnerDuration: 5000,
        customColors: CustomSliderColors(
          trackColor: Colors.red[200],
          progressBarColor: Colors.red[500],
          hideShadow: true,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
          ),
          bottomLabelText: 'minutes',
          bottomLabelStyle: TextStyle(
            color: Colors.white60,
          ),
        ),
      ),
      onChange: (seconds) {
        var secondsRoundedDownToNearestMinute = seconds - (seconds % 60);
        valueChanged(secondsRoundedDownToNearestMinute);
      },
    );
  }
}
