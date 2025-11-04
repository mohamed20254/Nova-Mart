import '../../domain/entitty/user_entitiy.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    required super.createdAt,
    super.emailVerified = false,
    super.photoUrl,
    super.phone,
  });

  /// 🔁 من Firestore أو JSON إلى Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      phone: map['phone'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔁 من Model إلى Map (عشان نرفعها لـ Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'emailVerified': emailVerified,
      'createdAt': createdAt.toIso8601String(),
      'phone': phone,
    };
  }

  /// 🔁 من Firebase User (auth) مباشرة إلى Model
  factory UserModel.fromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      emailVerified: user.emailVerified,
      createdAt: DateTime.now(),
    );
  }

  UserModel copyWithModel({
    final String? uid,
    final String? email,
    final String? displayName,
    final String? photoUrl,
    final String? phone,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt,
      phone: phone ?? this.phone,
    );
  }
}
