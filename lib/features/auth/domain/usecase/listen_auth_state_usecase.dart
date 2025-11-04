import 'package:ecomerc_app_with_admin/features/auth/domain/repo/user_reposatory.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListenAuthStateUsecase {
  final UserReposatory userReposatoryimpl;
  ListenAuthStateUsecase(this.userReposatoryimpl);
  Stream<User?> call() => userReposatoryimpl.listenToAuthState();
}
