import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer/constants.dart';

class Data with ChangeNotifier {
  Timer? _timer;
  int _waitTimeInSec = waitTime;
  late int _currentWaitTimeInSec;
  double _percent = 1.0;
  late String _timeStr;
  bool _isRun = false;
  bool h = false;

  int get getDataWaitTimeInSec => _waitTimeInSec;
  int get getDataCurrentTime => _currentWaitTimeInSec;
  double get getDataPercent => _percent;
  String get getDataTimeStr => _timeStr;
  bool get getDataIsRun => _isRun;

  void readWaitTimeInSec(newTime) {
    _waitTimeInSec = newTime;

    if (!h) {
      _currentWaitTimeInSec = _waitTimeInSec;
      h = true;
    }
  }

  void start(BuildContext context) {
    if (_currentWaitTimeInSec > 0) {
      _isRun = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _currentWaitTimeInSec -= 1;

        calculationTime();

        if (_currentWaitTimeInSec <= 0) {
          h = false;
          pause();
        }

        notifyListeners();
      });
    }
  }

  void restart() {
    _currentWaitTimeInSec = _waitTimeInSec;
    h = false;
    calculationTime();
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    _isRun = false;
    notifyListeners();
  }

  void calculationTime() {
    var minuteStr = (_currentWaitTimeInSec ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_currentWaitTimeInSec % 60).toString().padLeft(2, '0');
    _percent = _currentWaitTimeInSec / _waitTimeInSec;
    _timeStr = '$minuteStr:$secondStr';
  }
}
