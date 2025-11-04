import 'package:ecomerc_app_with_admin/features/auth/data/model/user_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class OuthRemoteDatasourcse {
  Future<UserModel> creatAccount({
    required final String name,
    required final String email,
    required final String password,
    required final String phone,
  });
  Future<UserModel> login({required String email, required String password});

  Future<void> sendEmailVerification();

  Future<void> logout();

  Future<UserModel> cheackemailverificaion();

  Stream<User?> listenToAuthState();

  Future<UserModel> googlesignin();
  Future<void> resetPAssword(String email);
  Future<UserModel> fatchUser();
  String get uid;
}

class OuthRemoteDatasourcseImpl implements OuthRemoteDatasourcse {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  OuthRemoteDatasourcseImpl({
    required final FirebaseAuth firebaseouth,
    required final FirebaseFirestore firebasstore,
  }) : _auth = firebaseouth,
       _firestore = firebasstore;

  //---------------------------creat account
  @override
  Future<UserModel> creatAccount({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final usercredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = usercredential.user?.uid;
    final UserModel newUser = UserModel(
      phone: phone,
      uid: uid!,
      email: email,
      displayName: name,
      createdAt: DateTime.now(),
      emailVerified: false,
    );
    _firestore.collection('user').doc(uid).set(newUser.toMap());
    // await sendEmailVerification();
    return newUser;
  }

  //---------------------------checkemail $$ updateUser
  Future<UserModel> cheackemailverificaion() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');
    for (int i = 0; i < 5; i++) {
      await user.reload();
      final refreshuser = _auth.currentUser;
      if (refreshuser != null && refreshuser.emailVerified) {
        await _firestore.collection('user').doc(user.uid).update({
          'emailVerified': true,
        });

        final doc = await _firestore.collection('user').doc(user.uid).get();
        return UserModel.fromMap(doc.data()!);
      }
      await Future.delayed(Duration(seconds: 2));
    }

    throw Exception('Email not verified yet');
  }

  //---------------------------------login
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    if (!userCredential.user!.emailVerified) {
      throw Exception("user-unveifi");
    }
    final user = await _firestore
        .collection("user")
        .doc(userCredential.user?.uid)
        .get();
    UserModel userModel = UserModel.fromMap(user.data()!);
    return userModel;
  }

  //------------------------------------------lgoout
  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  //-----------------------------------send email verfication
  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await _auth.currentUser!.sendEmailVerification();
    }
  }

  //---------------------------------------listentoauth state
  @override
  Stream<User?> listenToAuthState() {
    return _auth.authStateChanges();
  }

  @override
  Future<UserModel> googlesignin() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    await signIn.initialize(
      clientId:
          "402516449261-vg4h7tcfalpe9542f4r4hansufo7srgh.apps.googleusercontent.com",
    );

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await signIn.authenticate();

    if (googleUser == null) throw Exception("user is close");
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final String uid = userCredential.user!.uid;
    final doc = await _firestore.collection('user').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      UserModel usermodel = UserModel(
        uid: uid,
        email: userCredential.user!.email ?? "",
        displayName: userCredential.user!.displayName ?? "",
        createdAt: DateTime.now(),
        emailVerified: userCredential.user!.emailVerified,
        phone: userCredential.user!.photoURL ?? "",
        photoUrl: userCredential.user!.photoURL ?? "",
      );
      _firestore
          .collection('user')
          .doc(userCredential.user!.uid)
          .set(usermodel.toMap());
      return usermodel;
    }
  }

  @override
  Future<void> resetPAssword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserModel> fatchUser() async {
    final uid = _auth.currentUser!.uid;
    final data = await _firestore.collection('user').doc(uid).get();
    if (data.exists) {
      return UserModel.fromMap(data.data()!);
    } else {
      throw Exception("user not found");
    }
  }

  @override
  String get uid => _auth.currentUser!.uid;
}
