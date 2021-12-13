import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/src/bloc_widget/bloc/timer_bloc.dart';

class BLoCTimerPage extends StatelessWidget {
  final int _waitTimeInSec;

  const BLoCTimerPage({Key? key, required int waitTimeInSec})
      : _waitTimeInSec = waitTimeInSec,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(waitTimeInSec: _waitTimeInSec),
      child: const _BlocTimerPage(),
    );
  }
}

class _BlocTimerPage extends StatelessWidget {
  const _BlocTimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<TimerBloc, TimerState>(listener: (context, state) {
      if (state is TimerRunComplete) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Finish")));
      }
    }, child: BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
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
                          value: state.percent,
                          backgroundColor: Colors.red[800],
                          strokeWidth: 3,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white)),
                    ),
                    Positioned(
                        child: Text(
                      state.timeStr,
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
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  height: size.height * 0.12,
                  width: size.height * 0.12,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                      backgroundColor: Colors.grey[800],
                      onPressed: () {},
                      child: const Icon(Icons.restart_alt)),
                ),
              ),
              Container(
                  height: size.height * 0.12,
                  width: size.height * 0.12,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                      backgroundColor: Colors.grey[800],
                      onPressed: () {},
                      child: state.isRun
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
    }));
  }
}
