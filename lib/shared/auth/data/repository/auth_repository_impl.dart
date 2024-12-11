import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../domain/exceptions/auth_exceptions.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../models/user_credentials_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._remoteDatasource,
    this._talker,
  );

  final AuthRemoteDatasource _remoteDatasource;
  final Talker _talker;

  @override
  Stream<User?> get onAuthUpdate => _remoteDatasource.onAuthUpdate;

  @override
  Future<AuthResult<bool>> isUserExist(String email) async {
    try {
      final result = await _remoteDatasource.isUserExist(email);
      return AuthResult.success(result);
    } catch (e, st) {
      _talker.handle(e, st);
      final ex = AuthException('Failed user existing check');
      return AuthResult.failure(ex);
    }
  }

  @override
  Future<void> signUpWithPassword(String email, String password) async {
    try {
      final creds = UserCredentialsModel(email: email, password: password);
      return _remoteDatasource.signUpWithPassword(creds);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signInWithPassword(String email, String password) async {}

  @override
  Future<void> signInWithGoogle() async {}

  @override
  Future<void> signOut() async {}
}

abstract class Result<L, R> {
  Either<L, R> get value;

  T fold<T>(T Function(L) ifLeft, T Function(R) ifRight);
}

class AuthResult<T> implements Result<AuthException, T> {
  AuthResult(this.value);

  @override
  Either<AuthException, T> value;

  AuthResult.success(T data) : value = Right(data);

  AuthResult.failure(AuthException exception) : value = Left(exception);

  @override
  C fold<C>(C Function(AuthException) ifLeft, C Function(T) ifRight) {
    return value.fold(ifLeft: ifLeft, ifRight: ifRight);
  }
}
