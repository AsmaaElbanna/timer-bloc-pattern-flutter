import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();
  @override
  List<Object?> get props => [];
}

class Start extends TimerEvent {
  final int duration;

  const Start(this.duration);

  @override
  String toString() {
    return 'Start {duration is $duration}';
  }
}

class Pause extends TimerEvent{}
class Resume extends TimerEvent{}
class Reset extends TimerEvent{}

class Tick extends TimerEvent{
  final int  duration;

  Tick(this.duration);
  @override
  List<Object?> get props => [duration];
  @override
  String toString() {
    return 'Tick {duration is $duration}';
  }

}
