import 'package:ai_chat_voice/bloc/conversation_bloc.dart';
import 'package:ai_chat_voice/bloc/conversation_event.dart';
import 'package:ai_chat_voice/bloc/conversation_state.dart';
import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:ai_chat_voice/bloc/navigation_bloc/navigation_event.dart';
import 'package:ai_chat_voice/feature_box.dart';

import 'package:ai_chat_voice/pallet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    //_flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc.myConversationBloc,
//############################ BlocConsumer ########################################
      child: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          if (state is ConversationStateUninitilized) {
            BlocProvider.of<ConversationBloc>(context)
                .add(const ConversationEventInitlize());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                leading: const Icon(Icons.menu),
                title: const Text('Chivita'),
              ),
              body: Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 15,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      /*### Assistant Image ####*/
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Pallete.assistantCircleColor,
                                shape: BoxShape.circle),
                          ),
                          ClipOval(
                            child: Image.asset(
                              'assets/images/virtualAssistant.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                      /*### Chat Bubble ####*/
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        //width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.symmetric(horizontal: 30)
                            .copyWith(top: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).copyWith(
                            topLeft: Radius.zero,
                          ),
                          border: Border.all(
                            color: Pallete.borderColor,
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Good morning, what task can I do for you?',
                          style: TextStyle(
                            color: Pallete.mainFontColor,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Here are a few features',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //##### Fetrues
                      Features(
                          myNavFunc: () {
                            BlocProvider.of<NavBloc>(context)
                                .add(const NavEventGoChatGPTView());
                          },
                          color: Pallete.firstSuggestionBoxColor,
                          title: 'ChatGPT',
                          text:
                              'A smart way to stay organanized and informed with ChatGPT'),
                      Features(
                          myNavFunc: () {},
                          color: Pallete.secondSuggestionBoxColor,
                          title: 'Dall-E',
                          text:
                              'Get inspired and stay creative with your personal assistant powered by Dall-E'),
                      Features(
                          myNavFunc: () {},
                          color: Pallete.thirdSuggestionBoxColor,
                          title: 'Smart Voice Assistant',
                          text:
                              'Get the best of both worlds with voice assitant powered by Dall-E and ChatGPT'),
                    ],
                  ),
                ),
              ),
              floatingActionButton: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //############################ CancelListeningButton(event) ########################################
                    Container(
                      height: 70,
                      margin: const EdgeInsets.only(right: 20),
                      child: FloatingActionButton.extended(
                        extendedPadding: const EdgeInsetsDirectional.only(
                            start: 15, end: 15),
                        isExtended: true,
                        onPressed: () async {
                          BlocProvider.of<ConversationBloc>(context)
                              .add(const ConversationEventCancelButton());
                        },
                        label: const Column(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 30,
                            ),
                            Text('cancel'),
                          ],
                        ),
                      ),
                    ),
                    //############################ ListenButton(event) ########################################
                    Container(
                      height: 70,
                      margin: const EdgeInsets.only(left: 20),
                      child: FloatingActionButton.extended(
                        extendedPadding: const EdgeInsetsDirectional.only(
                            start: 15, end: 15),
                        onPressed: () async {
                          BlocProvider.of<ConversationBloc>(context)
                              .add(const ConversationEventSpeakButton());
                        },
                        //############################ BUILDER->ListenButton ########################################
                        label: BlocBuilder<ConversationBloc, ConversationState>(
                          builder: (context, state) {
                            if (state is ConversationStateListening) {
                              return const Column(
                                children: [
                                  Icon(
                                    Icons.hearing,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  Text('Listening ...'),
                                ],
                              );
                            } else {
                              return const Column(
                                children: [
                                  Icon(
                                    Icons.mic,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                  Text('Speak'),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          }
        },
      ),
    );
  }
}
