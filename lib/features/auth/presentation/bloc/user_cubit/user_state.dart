part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

//======================   user lodaing state
final class UserInitial extends UserState {}

final class Userlodingstate extends UserState {}

final class UsersuccessState extends UserState {
  final UserEntity userEntity;

  const UsersuccessState({required this.userEntity});
  @override
  List<Object?> get props => [userEntity];
}

class UserFailureState extends UserState {
  final String messige;

  const UserFailureState({required this.messige});
  @override
  List<Object?> get props => [messige];
}
