import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> currentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<DocumentSnapshot> currentUserData(FirebaseUser user) async {
    return await Firestore.instance
        .collection('users')
        .document(user.uid)
        .get();
  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }

  Future<FirebaseUser> register(String email, String password, String name,
      String phone, String address) async {
    return await _saveUser(_firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password));
  }

  Future<FirebaseUser> login(AuthCredential credential) async {
    return await _saveUser(_firebaseAuth.signInWithCredential(credential));
  }

  Future<FirebaseUser> phoneLogin(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    return await _saveUser(_firebaseAuth.signInWithCredential(credential));
  }

  Future<FirebaseUser> emailLogin(String email, String password) async {
    return await _saveUser(_firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password));
  }

  Future<FirebaseUser> _saveUser(Future<AuthResult> signIn) async {
    final AuthResult result = await signIn;
    return result.user;
  }
}
