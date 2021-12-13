import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer/src/cubit_widget/cubit/cubit_timer_cubit.dart';

class CubitTimerPage extends StatelessWidget {
  const CubitTimerPage({Key? key, required this.waitTimeInSec})
      : super(key: key);
  final int waitTimeInSec;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TimerCubit(waitTimeInSec),
        child: const _CubitTimerPage());
  }
}

class _CubitTimerPage extends StatelessWidget {
  const _CubitTimerPage({Key? key}) : super(key: key);
  //Timer? _timer;
  //late int _waitTime;
  //var _percent = 1.0;
  // var isStart = false;
  // var timeStr = '05:00';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TimerCubit, TimerState>(
        //buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
      if (state is TimerInitial) {
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
                        state.waitTime,
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
                        onPressed: () {
                          context.read<TimerCubit>().mapTimerResetToState();
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
                        context
                            .read<TimerCubit>()
                            .mapTimerStartedToState(context);
                      },
                      child: const Icon(Icons.play_arrow),
                    )),
              ],
            ),
          ],
        ));
      }
      ;
      if (state is TimerRunState) {
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
                        state.currentTime,
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
                          context.read<TimerCubit>().mapTimerResetToState();
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
                        context.read<TimerCubit>().mapTimerPauseToState();
                      },
                      child: const Icon(Icons.pause),
                    )),
              ],
            ),
          ],
        ));
      }
      ;
      if (state is TimerPauseState) {
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
                        state.currentTime,
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
                          context.read<TimerCubit>().mapTimerResetToState();
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
                        context
                            .read<TimerCubit>()
                            .mapTimerStartedToState(context);
                      },
                      child: const Icon(Icons.play_arrow),
                    )),
              ],
            ),
          ],
        ));
      } else {
        return Container(
          child: Text('error'),
        );
      }
    });
  }
}
