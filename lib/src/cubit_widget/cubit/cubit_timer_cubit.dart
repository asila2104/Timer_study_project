import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

part 'cubit_timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit(int waitTimeInSec)
      : _waitTimeInSec = waitTimeInSec,
        _currentWaitTimeInSec = waitTimeInSec,
        percent = 1,
        timeStr = '${waitTimeInSec ~/ 60}:${waitTimeInSec % 60}',
        super(
            TimerInitial('${waitTimeInSec ~/ 60} : ${waitTimeInSec % 60}', 1));

  Timer? _timer;
  final int _waitTimeInSec;
  int _currentWaitTimeInSec;

  double percent = 1.0;

  var timeStr = '05:00';

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> mapTimerStartedToState(BuildContext context) async {
    emit(TimerRunState(timeStr, percent, _waitTimeInSec));
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      _currentWaitTimeInSec -= 1;
      percent = _currentWaitTimeInSec / _waitTimeInSec;
      timeStr = await _calculationTime(_currentWaitTimeInSec);
      emit(TimerRunState(timeStr, percent, _waitTimeInSec));
      if (_currentWaitTimeInSec < 0) {
        _currentWaitTimeInSec = _waitTimeInSec;
        percent = 1;
        timeStr = await _calculationTime(_currentWaitTimeInSec);
        _timer?.cancel();
        emit(TimerRunComplete());
        emit(TimerInitial(timeStr, 1));
      }
    });
  }

  Future<void> mapTimerResetToState() async {
    _currentWaitTimeInSec = _waitTimeInSec;
    percent = 1;
    timeStr = await _calculationTime(_currentWaitTimeInSec);
    _timer?.cancel();
    emit(TimerRunState(timeStr, percent, _waitTimeInSec));
  }

  Future<void> mapTimerPauseToState() async {
    _timer?.cancel();
    emit(TimerPauseState(timeStr, percent));
  }

  Future<String> _calculationTime(int currentWaitTimeInSec) async {
    var minuteStr = (currentWaitTimeInSec ~/ 60).toString().padLeft(2, '0');
    var secondStr = (currentWaitTimeInSec % 60).toString().padLeft(2, '0');
    return '$minuteStr:$secondStr';
  }
}
