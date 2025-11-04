part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

// Initial state
class AuthInitial extends AuthState {}

// -------------------- LOGIN STATES --------------------

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserEntity user;
  const LoginSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailureState extends AuthState {
  final String message;
  const LoginFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// -------------------- SIGNUP STATES --------------------

class SignupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {
  final UserEntity user;
  const SignupSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class SignupFailureState extends AuthState {
  final String message;
  const SignupFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

//-----------------------------------checkEmailverfi
class CheckEVLoadingState extends AuthState {}

class CheckESuccessState extends AuthState {
  final UserEntity? user;
  const CheckESuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class CheckEVfailureState extends AuthState {
  final String message;
  const CheckEVfailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// ---------------------------------------sendEmailVerifi
class SendEVLoadingState extends AuthState {}

class SendESuccessState extends AuthState {
  const SendESuccessState();
}

class SendEVfailureState extends AuthState {
  final String message;
  const SendEVfailureState(this.message);

  @override
  List<Object?> get props => [message];
}

//====================================google sign state
class GoogleLoadinState extends AuthState {}

class GoogleSuccessState extends AuthState {
  final UserEntity user;
  const GoogleSuccessState(this.user);
  @override
  List<Object?> get props => [user];
}

class GoogleFailuerState extends AuthState {
  final String message;

  const GoogleFailuerState({required this.message});
  @override
  List<Object?> get props => [message];

  //resetpasswoed
}

class RestetPassLoadingState extends AuthState {}

class RestetPassSuccessState extends AuthState {}

class RestetPassFailuerState extends AuthState {
  final String message;
  const RestetPassFailuerState(this.message);
  @override
  List<Object?> get props => [message];
}

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutFailuerState extends AuthState {
  final String message;
  const LogoutFailuerState(this.message);
  @override
  List<Object?> get props => [message];
}
