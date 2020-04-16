import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/BLoC/pomodoro_bloc.dart';
import 'package:flutter_pomodoro/logic/pomodoro_state.dart';
import 'package:flutter_pomodoro/ui/about_page.dart';
import 'package:flutter_pomodoro/ui/time_selection_slider.dart';

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
  TextEditingController test = TextEditingController();
  int visibleTimeSeconds = 1;
  @override
  void initState() {
//    pomodoroBloc.start();
    super.initState();
  }

  @override
  void dispose() {
    pomodoroBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutPage();
              }));
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: pomodoroBloc.pomodoroStream,
          builder: (context, snapshot) {
            PomodoroState state = snapshot.data ??
                PomodoroState(isActive: false, currentTimeSeconds: 0);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    getTimeSelectionChild(state),
                    TimeDisplay(
                      currentTimeSeconds: state.currentTimeSeconds,
                      isCountingDown: state.isActive,
                    ),
                  ],
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: state.isActive
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        pomodoroBloc.toggle();
                      },
                    ),
                    RaisedButton(
                      child: Icon(Icons.stop),
                      onPressed: () {
                        pomodoroBloc.stop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  getTimeSelectionChild(PomodoroState state) {
    if (state.isActive) {
      return TimeSelectionSlider(
        key: Key("spinningSlider"),
        valueChanged: (double value) {},
        isAnimating: state.isActive,
      );
    } else {
      return TimeSelectionSlider(
        key: Key("editSlider"),
        valueChanged: (double value) {
          pomodoroBloc.updateTime(value.toInt());
        },
        isAnimating: state.isActive,
      );
    }
  }
}
