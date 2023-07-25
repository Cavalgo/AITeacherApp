import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_state.dart';
import 'package:ai_chat_voice/views/chat_gpt3/chat_gpt3_view.dart';
import 'package:ai_chat_voice/pallet.dart';
import 'package:ai_chat_voice/views/log-in-view/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  // Initilize firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice Assistance',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Pallete.whiteColor, centerTitle: true),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Cera Pro',
            color: Pallete.mainFontColor,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Cera Pro',
            color: Pallete.mainFontColor,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => NavBloc(),
        child: BlocBuilder<NavBloc, NavState>(
          builder: (context, state) {
            if (state is NavStateInHomePageView) {
              return LogInView();
              //return const ChatGPT3View();
            } else {
              return LogInView();
              //return const ChatGPT3View();
            }
          },
        ),
      ),
    );
  }
}
