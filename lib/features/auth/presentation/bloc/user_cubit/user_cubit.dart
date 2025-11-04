import 'package:bloc/bloc.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/entitty/user_entitiy.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:ecomerc_app_with_admin/features/auth/domain/usecase/ubdate_user_usecae.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUsecase getUserUsecase;
  final UbdateUserUsecae updateUserUsecase;
  UserCubit({required this.getUserUsecase, required this.updateUserUsecase})
    : super(UserInitial());
  Future<void> getUser() async {
    emit(Userlodingstate());
    final res = await getUserUsecase.call();
    res.fold(
      (failure) => emit(UserFailureState(messige: failure.messige)),
      (user) => emit(UsersuccessState(userEntity: user)),
    );
  }

  Future<void> ubdateUser({final String? name, final String? phone}) async {
    emit(Userlodingstate());
    final res = await updateUserUsecase.call(name, phone);
    res.fold((l) => emit(UserFailureState(messige: l.messige)), (r) async {
      await getUser();
    });
  }
}
