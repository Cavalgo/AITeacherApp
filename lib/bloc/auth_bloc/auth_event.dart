import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitilizeFirebase extends AuthEvent {
  const AuthEventInitilizeFirebase();
}

class AuthEventCheckIfLoggedIn extends AuthEvent {
  const AuthEventCheckIfLoggedIn();
}

class AuthEventGoToRegister extends AuthEvent {
  const AuthEventGoToRegister();
}

class AuthEventGoToLogIn extends AuthEvent {
  const AuthEventGoToLogIn();
}

class AuthEventRegisterWithEmail extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final BuildContext context;
  const AuthEventRegisterWithEmail(
    this.email,
    this.password,
    this.name,
    this.context,
  );
}

class AuthEventLogInWithEmail extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const AuthEventLogInWithEmail(
    this.email,
    this.password,
    this.context,
  );
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventSendVerificationEmail extends AuthEvent {
  const AuthEventSendVerificationEmail();
}

class AuthEventReloadUser extends AuthEvent {
  const AuthEventReloadUser();
}

class AuthEventResetPassword extends AuthEvent {
  const AuthEventResetPassword();
}
