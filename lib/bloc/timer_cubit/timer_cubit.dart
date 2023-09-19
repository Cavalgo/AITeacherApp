import 'dart:async';
import 'package:wakelock/wakelock.dart';
import 'package:ai_chat_voice/bloc/timer_cubit/timer_sate.dart';
import 'package:bloc/bloc.dart';

class TimerCubit extends Cubit<TimerState> {
  Timer? _timer;

  //Constructor
  TimerCubit() : super(const TimerInitialState());

  startTimer([int? time]) {
    Wakelock.enabled;
    if (time != null) {
      emit(TimerProgressState(time));
    } else {
      emit(const TimerProgressState(0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  onTick(_) {
    if (state is TimerProgressState) {
      TimerProgressState wip = state as TimerProgressState;
      if (wip.elapsed! < 5) {
        emit(TimerProgressState(wip.elapsed! + 1));
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const TimerInitialState());
      }
    }
  }
}
