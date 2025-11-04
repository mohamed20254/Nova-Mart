part of 'timer_cubit.dart';

sealed class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object?> get props => [];
}

final class TimerInitial extends TimerState {}

class ResendEmailTimerState extends TimerState {
  final int secondsLeft;
  final bool canResend;

  const ResendEmailTimerState({
    required this.secondsLeft,
    required this.canResend,
  });

  @override
  List<Object?> get props => [secondsLeft, canResend];
}
