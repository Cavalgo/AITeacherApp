import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int? elapsed;
  const TimerState(this.elapsed);
}

class TimerInitialState extends TimerState {
  const TimerInitialState() : super(0);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TimerProgressState extends TimerState {
  const TimerProgressState(int? elapsed) : super(elapsed);

  @override
  // TODO: implement props
  List<Object?> get props => [elapsed];
}
