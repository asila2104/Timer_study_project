import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/src/provider_widget/provider.dart';

class ProviderTimerPage extends StatelessWidget {
  const ProviderTimerPage({Key? key, required this.waitTimeInSec})
      : super(key: key);
  final int waitTimeInSec;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
        create: (BuildContext context) => Data(),
        builder: (context, child) => page(context));
  }

  Widget page(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Provider.of<Data>(context, listen: false).readWaitTimeInSec(waitTimeInSec);

    Provider.of<Data>(context, listen: false).calculationTime();
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
                        value: context.watch<Data>().getDataPercent,
                        backgroundColor: Colors.red[800],
                        strokeWidth: 3,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                  Positioned(
                      child: Text(
                    context.watch<Data>().getDataTimeStr,
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
                      context.read<Data>().restart();
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
                      Provider.of<Data>(context, listen: false).getDataIsRun
                          ? Provider.of<Data>(context, listen: false).pause()
                          : Provider.of<Data>(context, listen: false)
                              .start(context);
                    },
                    child: context.watch<Data>().getDataIsRun
                        ? const Icon(Icons.pause)
                        : Icon(Icons.play_arrow))),
          ],
        ),
      ],
    ));
  }
}
