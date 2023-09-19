import 'package:ai_chat_voice/Widgets/generic_alet_diaglo.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_event.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_state.dart';
import 'package:ai_chat_voice/services/authentication/auth_exception.dart';
import 'package:ai_chat_voice/services/authentication/fb_auth_service.dart';
import 'package:bloc/bloc.dart';

import '../../services/authentication/my_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FBAuthService myFBAuthService = FBAuthService();
  MyUser? myUSer;
/*Singletone*/
  static final AuthBloc _authBlocSingleton = AuthBloc._internal();
  factory AuthBloc({
    required FBAuthService myFBAuthService,
  }) {
    return _authBlocSingleton;
  }
/*Singletone*/

//Implementation
  AuthBloc._internal() : super(const AuthStateUninitilizedFirebase()) {
    on<AuthEventInitilizeFirebase>((event, emit) async {
      await myFBAuthService.initlizeFirebase();
      add(const AuthEventCheckIfLoggedIn());
    });
    on<AuthEventCheckIfLoggedIn>((event, emit) async {
      myUSer = myFBAuthService.getCurrentUser();
      if (myUSer != null) {
        emit(const AuthStateLoggedIn());
      } else {
        emit(const AuthStateNotLoggedIn());
      }
    });
    on<AuthEventGoToRegister>((event, emit) {
      emit(const AuthStateInRegisterProcess());
    });
    on<AuthEventGoToLogIn>((event, emit) {
      emit(const AuthStateNotLoggedIn());
    });
    on<AuthEventRegisterWithEmail>((event, emit) async {
      try {
        await myFBAuthService.register(
          email: event.email,
          password: event.password,
          name: event.name,
        );
        emit(const AuthStateLoggedIn());
      } catch (ex) {
        MyAuthException e = ex as MyAuthException;
        showGenericAlertDialog(
            context: event.context, title: e.reason, content: e.description);
      }
    });
    on<AuthEventLogInWithEmail>((event, emit) async {
      try {
        await myFBAuthService.logIn(
          email: event.email,
          password: event.password,
        );
        emit(const AuthStateLoggedIn());
      } catch (ex) {
        MyAuthException e = ex as MyAuthException;
        showGenericAlertDialog(
            context: event.context, title: e.reason, content: e.description);
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      await myFBAuthService.logOut();
      emit(const AuthStateNotLoggedIn());
    });
  }
}
