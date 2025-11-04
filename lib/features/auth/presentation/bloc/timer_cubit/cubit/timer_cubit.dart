import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());
  bool isclose = false;
  Future<void> startResendTimer() async {
    int second = 60;

    try {
      emit(ResendEmailTimerState(secondsLeft: second, canResend: false));
      while (second > 0) {
        if (isClosed || isclose) break;
        await Future.delayed(const Duration(seconds: 1));
        second--;
        if (isClosed || isclose) break;
        emit(ResendEmailTimerState(secondsLeft: second, canResend: false));
      }
      if (isClosed || isclose) return;
      emit(ResendEmailTimerState(secondsLeft: second, canResend: true));
    } catch (e) {
      return;
    }
  }

  void stopTimer() {
    isclose = true;
  }

  @override
  Future<void> close() {
    isclose = true;
    return super.close();
  }
}
