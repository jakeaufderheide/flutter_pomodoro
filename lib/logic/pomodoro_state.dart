class PomodoroState {
  const PomodoroState({
    this.isActive,
    this.currentTimeSeconds,
    this.isTimerFinished,
  });

  final isActive;
  final currentTimeSeconds;
  final isTimerFinished;
}
