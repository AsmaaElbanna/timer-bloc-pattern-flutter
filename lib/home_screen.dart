import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_project/bloc/bloc.dart';
import 'package:timer_project/bloc/timer_bloc.dart';
import 'package:timer_project/bloc/timer_state.dart';
import 'package:timer_project/wave_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Timer',
          style: TextStyle(color: Colors.white),
        )),
        body: Stack(
          children: [
            WaveBackground(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(
                    child: BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                        final String minuteSection =
                            ((state.duration / 60) % 60)
                                .floor()
                                .toString()
                                .padLeft(2, '0');
                        final String secondSection = (state.duration % 60)
                            .floor()
                            .toString()
                            .padLeft(2, '0');
                        return Text(
                          '$minuteSection:$secondSection',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<TimerBloc, TimerState>(
                  // condition:condition: (prevState, currState) =>
                  //               currState.runtimeType != prevState.runtimeType,
                  buildWhen: (prevState, currState) =>
                      currState.runtimeType != prevState.runtimeType,
                  builder: (context, state) => ActionsState(),
                ),
              ],
            )
          ],
        ));
  }
}

class ActionsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _mapStateToActionButtons(
            timerBloc: BlocProvider.of<TimerBloc>(context)));
  }
}

List<Widget> _mapStateToActionButtons({required TimerBloc timerBloc}) {
  final Color iconColor = Color(0xFF1B476D);
  final Color flatButtonColor = Colors.white;
  final TimerState currentState = timerBloc.state;
  if (currentState is Ready) {
    return [
      FloatingActionButton(
          backgroundColor: flatButtonColor,
          child: Icon(
            Icons.play_arrow,
            color: iconColor,
          ),
          onPressed: () {
            timerBloc.add(Start(currentState.duration));
          })
    ];
  }
  if (currentState is Running) {
    return [
      FloatingActionButton(
          backgroundColor: flatButtonColor,
          child: Icon(
            Icons.pause,
            color: iconColor,
          ),
          onPressed: () {
            timerBloc.add(Pause());
          }),
      FloatingActionButton(
          backgroundColor: flatButtonColor,
          child: Icon(
            Icons.replay,
            color: iconColor,
          ),
          onPressed: () {
            timerBloc.add(Reset());
          }),
    ];
  }
  if (currentState is Pause) {
    return [
      FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            timerBloc.add(Resume());
          }),
      FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(Reset());
          }),
    ];
  }
  if (currentState is Finished) {
    return [
      FloatingActionButton(
          backgroundColor: flatButtonColor,
          child: Icon(
            Icons.play_arrow,
            color: iconColor,
          ),
          onPressed: () {
            timerBloc.add(Reset());
          })
    ];
  }

  return [
    FloatingActionButton(
        backgroundColor: flatButtonColor,
        child: Icon(
          Icons.play_arrow,
          color: iconColor,
        ),
        onPressed: () {
          timerBloc.add(Resume());
        }),
    FloatingActionButton(
        backgroundColor: flatButtonColor,
        child: Icon(
          Icons.replay,
          color: iconColor,
        ),
        onPressed: () {
          timerBloc.add(Reset());
        }),
  ];
}
