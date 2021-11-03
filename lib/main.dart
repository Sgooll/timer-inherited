import 'package:flutter/material.dart';
import 'package:timer_inherited/src/timer_context.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateWidget(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    final provider = TimerInheritedWidget.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Timer"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      provider?.restart();
                    },
                    child: const Icon(Icons.restart_alt),
                  )),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        value: provider?.percent,
                        backgroundColor: Colors.red[800],
                        strokeWidth: 8,
                      )),
                  Positioned(
                      child: Text(
                        "${provider?.timeStr}",
                        style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ))
                ],
              ),
              Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      provider!.isStart ? provider.pause() : provider.start(context);
                    },
                    child: provider!.isStart
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                  )),
            ],
          ),
        ));
  }
}
