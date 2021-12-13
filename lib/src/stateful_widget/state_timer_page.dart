import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timer/constants.dart';

class StateTimerPage extends StatefulWidget {
  final int waitTimeInSec;

  const StateTimerPage({Key? key, required this.waitTimeInSec})
      : super(key: key);

  @override
  _StateTimerPageState createState() => _StateTimerPageState();
}

class _StateTimerPageState extends State<StateTimerPage> {
  Timer? _timer;
  late int _waitTime;
  var _percent = 1.0;
  var isStart = false;
  var timeStr = '05:00';

  @override
  void initState() {
    super.initState();
    _waitTime = widget.waitTimeInSec;
    _calculationTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void start(BuildContext context) {
    if (_waitTime > 0) {
      setState(() {
        isStart = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitTime -= 1;
        _calculationTime();
        if (_waitTime <= 0) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Finish")));
          pause();
        }
      });
    }
  }

  void restart() {
    _waitTime = widget.waitTimeInSec;
    _calculationTime();
    pause();
  }

  void pause() {
    _timer?.cancel();
    setState(() {
      isStart = false;
    });
  }

  void _calculationTime() {
    var minuteStr = (_waitTime ~/ 60).toString().padLeft(2, '0');
    var secondStr = (_waitTime % 60).toString().padLeft(2, '0');
    setState(() {
      _percent = _waitTime / widget.waitTimeInSec;
      timeStr = '$minuteStr:$secondStr';
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
                    timeStr,
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
                      isStart ? pause() : start(context);
                    },
                    child: isStart
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
}
