import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_credentials_model.dart';

abstract class AuthRemoteDatasource {
  Stream<User?> get onAuthUpdate;

  Future<bool> isUserExist(String email);

  Future<void> signInWithPassword(UserCredentialsModel credentials);

  Future<void> signUpWithPassword(UserCredentialsModel credentials);

  Future<void> signInWithGoogle();

  Future<void> signOut();

  Future<void> dispose();
}
