import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimeSelectionSlider extends StatelessWidget {
  TimeSelectionSlider({this.valueChanged});
  final Function valueChanged;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 5,
      max: 60,
      initialValue: 25,
      innerWidget: (value) {
        return null;
      },
      appearance: CircularSliderAppearance(
        size: 250.0,
        customColors: CustomSliderColors(
          trackColor: Colors.red[200],
          progressBarColor: Colors.red[500],
          hideShadow: true,
        ),
        infoProperties: InfoProperties(
          modifier: (value) {
            return value.floor().toString();
          },
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
      onChange: (value) {
        valueChanged(value);
      },
    );
  }
}
