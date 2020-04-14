import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/constants.dart';
import 'package:flutter_pomodoro/logic/pomodoro_timer.dart';
import 'package:flutter_pomodoro/ui/time_selection_slider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'time_display.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pomodoro App',
      theme: ThemeData.dark().copyWith(
        // This is the theme of your application.
        primaryColor: Colors.red,
        primaryColorDark: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(buttonColor: Colors.red),
      ),
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  PomodoroTimer pomodoro = PomodoroTimer();
  bool isCountdownActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                TimeSelectionSlider(
                  valueChanged: (value) {
                    setState(() {
                      pomodoro.updateTime(value);
                    });
                  },
                  isAnimating: false,
                ),
                TimeDisplay(
                    currentTimeSeconds: pomodoro.getCurrentTime(),
                    isCountingDown: isCountdownActive),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: isCountdownActive
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                  onPressed: isCountdownActive
                      ? () {
                          pauseTimer();
                        }
                      : () {
                          activateTimer();
                        },
                ),
                RaisedButton(
                  child: Icon(Icons.stop),
                  onPressed: () {
                    setState(() {
                      pauseTimer();
                      pomodoro.reset();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pauseTimer() {
    setState(() {
      isCountdownActive = false;
      timer.cancel();
    });
  }
}
