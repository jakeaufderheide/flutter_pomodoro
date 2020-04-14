import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/constants.dart';
import 'package:flutter_pomodoro/time_selection_slider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
  int currentTimeMinutes;
  void updateTime(double time) {
    setState(() {
      currentTimeMinutes = time.floor().toInt();
      print(currentTimeMinutes);
    });
  }

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
                  valueChanged: updateTime,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      currentTimeMinutes.toString(),
                      style: kMinuteTextStyle,
                    ),
                    Text('minutes'),
                  ],
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: () {
                    print('button pressed');
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.stop),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
