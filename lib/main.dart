import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_state.dart';
import 'package:ai_chat_voice/views/chat_gpt3/chat_gpt3_view.dart';
import 'package:ai_chat_voice/pallet.dart';
import 'package:ai_chat_voice/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
              return const ChatGPT3View();
            } else {
              return const ChatGPT3View();
            }
          },
        ),
      ),
    );
  }
}
