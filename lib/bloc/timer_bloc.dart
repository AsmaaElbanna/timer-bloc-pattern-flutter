import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_project/bloc/timer_event.dart';
import 'package:timer_project/bloc/timer_state.dart';
import 'package:timer_project/ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final int _duration = 5;
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({@required Ticker? ticker})
      : _ticker = ticker!,
        super(Ready(5));

  //  @override
  // TimerState get initialState=>Ready(_duration);

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is Start) {
      Start start = event;
      yield Running(start.duration);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(start.duration).listen((d) {
        add(Tick(d));
      });
    } // end start event
    else if (event is Pause) {
      Pause pause = event;
      if (state is Running) {
        _tickerSubscription?.pause();
        yield Paused(state.duration);
      }
    } // end pause event
    else if (event is Resume) {
      Resume resume = event;
      if (state is Paused) {
        _tickerSubscription?.resume();
        yield Running(state.duration);
      }
    } //end resume event
    else if (event is Reset) {
      _tickerSubscription?.cancel();
      yield Ready(_duration);
    }// end reset event

    else if (event is Tick) {
      Tick tick = event;
      yield tick.duration > 0 ? Running(tick.duration) : Finished(0);
    } //end tick event
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
