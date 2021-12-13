import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timer/constants.dart';

class Inherited extends InheritedWidget {
  final int waitTimeInSec;

  const Inherited({Key? key, required this.child, required this.waitTimeInSec})
      : super(key: key, child: child);

  final Widget child;

  static Inherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Inherited>();
  }

  @override
  bool updateShouldNotify(Inherited oldWidget) {
    return waitTimeInSec != oldWidget.waitTimeInSec;
  }
}

class InheritedTimerPage extends StatefulWidget {
  @override
  _InheritedTimerPageState createState() => _InheritedTimerPageState();
}

class _InheritedTimerPageState extends State<InheritedTimerPage> {
  Timer? _timer;
  int _waitTimeInSec = waitTime;
  var _percent = 1.0;
  var _isStart = false;
  var _timeStr = '05:00';

  @override
  void initState() {
    super.initState();
    _waitTimeInSec = waitTime;
    _calculationTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void start(BuildContext context) {
    if (_waitTimeInSec > 0) {
      setState(() {
        _isStart = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitTimeInSec -= 1;
        _calculationTime();
        if (_waitTimeInSec <= 0) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Finish")));
          pause();
        }
      });
    }
  }

  void restart() {
    _waitTimeInSec = waitTime;
    _calculationTime();
    pause();
  }

  void pause() {
    _timer?.cancel();
    setState(() {
      _isStart = false;
    });
  }

  void _calculationTime() {
    var minuteStr = (_waitTimeInSec ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_waitTimeInSec % 60).toString().padLeft(2, '0');
    setState(() {
      _percent = _waitTimeInSec / waitTime;
      _timeStr = '$minuteStr:$secondStr';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: size.height * 0.25,
                    width: size.height * 0.25,
                    margin: const EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                        value: _percent,
                        backgroundColor: Colors.red[800],
                        strokeWidth: 3,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                  Positioned(
                      child: Text(
                    _timeStr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ))
                ],
              ))
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                height: size.height * 0.12,
                width: size.height * 0.12,
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton(
                    backgroundColor: Colors.grey[800],
                    onPressed: () {
                      restart();
                    },
                    child: const Icon(Icons.restart_alt)),
              ),
            ),
            Container(
                height: size.height * 0.12,
                width: size.height * 0.12,
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton(
                    backgroundColor: Colors.grey[800],
                    onPressed: () {
                      _isStart ? pause() : start(context);
                    },
                    child: _isStart
                        ? const Icon(
                            Icons.pause,
                          )
                        : const Icon(
                            Icons.play_arrow,
                          ))),
          ],
        ),
      ],
    ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
