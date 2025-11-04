class UserEntity {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? phone;
  final bool emailVerified;
  final DateTime createdAt;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.phone,
    required this.emailVerified,
    required this.createdAt,
  });

  UserEntity copyWith({
    final String? uid,
    final String? email,
    final String? displayName,
    final String? photoUrl,
    final String? phone,
    final bool? emailVerified,
    final DateTime? createdAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
