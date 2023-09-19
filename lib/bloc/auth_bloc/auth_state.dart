import 'package:flutter/foundation.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitilizedFirebase extends AuthState {
  const AuthStateUninitilizedFirebase();
}

class AuthStateNotLoggedIn extends AuthState {
  const AuthStateNotLoggedIn();
}

class AuthStateInRegisterProcess extends AuthState {
  const AuthStateInRegisterProcess();
}

class AuthStateInVerifyEmailProcess extends AuthState {
  const AuthStateInVerifyEmailProcess();
}

class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn();
}

class AuthStateResetPasswordProcess extends AuthState {
  const AuthStateResetPasswordProcess();
}
