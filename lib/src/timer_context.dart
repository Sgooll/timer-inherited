import 'dart:async';
import 'package:flutter/material.dart';

class StateWidget extends StatefulWidget {
  final Widget child;
  const StateWidget({Key? key, required this.child}) : super(key: key);

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  Timer? _timer;
  int currentWaitTime = 10;
  int waitTime = 10;
  bool isStart = false;
  double percent = 1.0;
  String timeStr = '';

  @override
  void initState() {
    _calculationTime();
    super.initState();
  }


  void start(BuildContext context) {
    if (currentWaitTime > 0) {
      setState(() {
        isStart = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        currentWaitTime -= 1;
        _calculationTime();
        if (currentWaitTime <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Finish')));
          pause();
        }
      });
    }
  }

  void restart() {
    currentWaitTime = waitTime;
    _calculationTime();
  }

  void pause() {
    _timer?.cancel();
    setState(() {
      isStart = false;
    });
  }

  void _calculationTime() {
    var minuteStr = (currentWaitTime ~/ 60).toString().padLeft(2, '0');
    var secondStr = (currentWaitTime % 60).toString().padLeft(2, '0');
    setState(() {
      percent = currentWaitTime / 10;
      timeStr = '$minuteStr:$secondStr';
    });
  }



  @override
  Widget build(BuildContext context) => TimerInheritedWidget(
      child: widget.child,
      waitTime: currentWaitTime,
      stateWidget: this,
      isStart: isStart);
}



class TimerInheritedWidget extends InheritedWidget {
  final int waitTime;
  final bool isStart;
  final _StateWidgetState stateWidget;

  const TimerInheritedWidget({
    Key? key,
    required Widget child,
    required this.waitTime,
    required this.stateWidget,
    required this.isStart,
}) : super(key: key, child: child);

  static _StateWidgetState? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<TimerInheritedWidget>()?.stateWidget;

  @override
  bool updateShouldNotify(TimerInheritedWidget oldWidget) =>
      oldWidget.waitTime != waitTime || oldWidget.isStart != isStart;
}