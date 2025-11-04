import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/auth/data/model/user_mode.dart';
import 'package:hive/hive.dart';

import '../../../../core/di/injection_container.dart';

abstract class AuthLocalDataSources {
  Future<UserModel?> getUserlocal(final String uid);
  Future<void> cacheUser(UserModel user);
  Future<void> clearUser(String uid);
  Future<void> updateUser(
    String uid, {
    final String? name,
    final String? phone,
  });
}

class AuthlocalDataSourcesImpl implements AuthLocalDataSources {
  final Box _box;

  AuthlocalDataSourcesImpl({required Box box}) : _box = box;

  @override
  Future<UserModel?> getUserlocal(final String uid) async {
    final data = _box.get(uid);
    if (data == null) return null;

    final UserModel userModel = UserModel.fromMap(
      Map<String, dynamic>.from(data),
    );
    return userModel;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await _box.put(user.uid, user.toMap()); // or put user if using adapter
  }

  @override
  Future<void> clearUser(String uid) async {
    await _box.delete(uid);
  }

  @override
  Future<void> updateUser(
    String uid, {
    final String? name,
    final String? phone,
  }) async {
    final data = _box.get(uid);
    UserModel userModel = UserModel.fromMap(Map<String, dynamic>.from(data));
    UserModel newUser = userModel.copyWithModel(
      displayName: name,
      phone: phone,
    );
    await _box.put(uid, newUser.toMap());
    FirebaseFirestore firestore = sl<FirebaseFirestore>();
    firestore.collection('user').doc(uid).update(newUser.toMap());
  }
}
