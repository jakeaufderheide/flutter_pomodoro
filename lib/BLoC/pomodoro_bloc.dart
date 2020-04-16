import 'dart:async';

import 'package:flutter_pomodoro/constants.dart';
import 'package:flutter_pomodoro/logic/pomodoro_state.dart';

import 'bloc.dart';

class PomodoroBloc implements Bloc {
  bool _isActive = false;
  bool _isTimerFinished = true;
  int _currentTimeSeconds = kInitialValueSeconds;

  final _currentTimeController = StreamController<PomodoroState>();
  Stream<PomodoroState> get pomodoroStream => _currentTimeController.stream;

  Timer timer;
  void _start() {
    _isActive = true;
    _publishState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTimeSeconds--;
      if (_currentTimeSeconds == 0) {
        _isActive = false;
        _isTimerFinished = true;
      }
      _publishState();
    });
  }

  void _pause() {
    _isActive = false;
    timer.cancel();
    _publishState();
  }

  @override
  void dispose() {
    _currentTimeController.close();
  }

  void updateTime(int value) {
    _currentTimeSeconds = value;
    _publishState();
  }

  void toggle() {
    if (!_isActive) {
      _start();
    } else {
      _pause();
    }
  }

  void stop() {
    _currentTimeSeconds = kInitialValueSeconds;
    _pause();
  }

  void _publishState() {
    _currentTimeController.sink.add(
      PomodoroState(
        isActive: _isActive,
        currentTimeSeconds: _currentTimeSeconds,
        isTimerFinished: _isTimerFinished,
      ),
    );
  }
}

final pomodoroBloc = PomodoroBloc();
