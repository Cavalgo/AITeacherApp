import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_event.dart';
import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const NavStateInHomePageView()) {
    on<NavEventGoToHomePageView>(
      (event, emit) {
        emit(const NavStateInHomePageView());
      },
    );
    on<NavEventGoChatGPTView>((event, emit) {
      emit(const NavStateInChatGPTView());
    });
  }
}
/*
on<>((event, emit) {});
*/