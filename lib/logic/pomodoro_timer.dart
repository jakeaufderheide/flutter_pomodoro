import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pomodoro/constants.dart';

class PomodoroTimer {
  PomodoroTimer(
      {@required Function(int) onTimeUpdated,
      @required Function(bool) onRunningStateUpdated}) {
    _onTimeUpdated = onTimeUpdated;
    _onRunningStateUpdated = onRunningStateUpdated;
  }
  Function(int) _onTimeUpdated;
  Function(bool) _onRunningStateUpdated;
  int _currentTimeSeconds = kInitialValueSeconds;
  bool _isCountdownActive = false;
  Timer _timer;

  void start() {
    if (!_isCountdownActive) {
      _isCountdownActive = true;
      _timer = Timer.periodic(
          Duration(
            seconds: 1,
          ), (timer) {
        _currentTimeSeconds--;
        _onTimeUpdated(_currentTimeSeconds);
      });
    }
  }

  void pause() {
    if (_isCountdownActive) {
      _isCountdownActive = false;
      _timer.cancel();
    }
  }

  void stop() {
    if (_isCountdownActive) {
      pause();
      _currentTimeSeconds = kInitialValueSeconds;
      _onTimeUpdated(_currentTimeSeconds);
    }
  }

  int getCurrentTime() {
    return _currentTimeSeconds;
  }

  void updateTime(value) {
    _currentTimeSeconds = value;
  }
}
