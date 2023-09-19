import 'package:ai_chat_voice/bloc/auth_bloc/auth_bloc.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_event.dart';
import 'package:ai_chat_voice/bloc/auth_bloc/auth_state.dart';
import 'package:ai_chat_voice/services/authentication/fb_auth_service.dart';
import 'package:ai_chat_voice/services/firestore/fs_provider.dart';
import 'package:ai_chat_voice/services/firestore/fs_service.dart';
import 'package:ai_chat_voice/utilities/pallet.dart';
import 'package:ai_chat_voice/views/home_page/home_page.dart';
import 'package:ai_chat_voice/views/log-in-view/log_in_view.dart';
import 'package:ai_chat_voice/views/log-in-view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Initilize firebase
  WidgetsFlutterBinding.ensureInitialized();
/*  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

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
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<FBAuthService>(
            create: (context) {
              return FBAuthService();
            },
          ),
          RepositoryProvider<FirestoreService>(
            create: (context) {
              return FirestoreService(
                provider: FirestoreProvider(),
              );
            },
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                myFBAuthService: context.read<FBAuthService>(),
              ),
            ),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthStateUninitilizedFirebase) {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventInitilizeFirebase());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AuthStateLoggedIn) {
                return const HomePage();
              } else if (state is AuthStateInRegisterProcess) {
                return const RegisterView();
              } else if (state is AuthStateNotLoggedIn) {
                return const LogInView();
              } else if (state is AuthStateInRegisterProcess) {
                return const RegisterView();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
                // return const ChatGPT3View();
              }
            },
          ),
        ),
      ),
    );
  }
}
