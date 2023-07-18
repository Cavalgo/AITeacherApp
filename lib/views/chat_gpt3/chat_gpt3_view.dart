import 'dart:developer';

import 'package:ai_chat_voice/bloc/conversation_bloc.dart';
import 'package:ai_chat_voice/bloc/conversation_event.dart';
import 'package:ai_chat_voice/bloc/conversation_state.dart';
import 'package:ai_chat_voice/views/chat_gpt3/chat_app_bar.dart';
import 'package:ai_chat_voice/views/chat_gpt3/user_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatGPT3View extends StatefulWidget {
  const ChatGPT3View({super.key});

  @override
  State<ChatGPT3View> createState() => _ChatGPT3ViewState();
}

class _ChatGPT3ViewState extends State<ChatGPT3View>
    with WidgetsBindingObserver {
  final FocusNode _focusNode = FocusNode();
  bool loadingResponse = false;
  TextEditingController myTextController = TextEditingController();
  ConversationBloc myConversationBloc = ConversationBloc.myConversationBloc;
  Widget? firstMessage;
  List<Map<String, String>> myConversationList = [
    {'role': 'system', 'message': 'Hola, en qué puedo ayudarte'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    myTextController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    myConversationBloc.add(const ConversationEventStopSpeaking());
    super.didChangeAppLifecycleState(state);
  }

  void setFocusAndShowKeyboard(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
    SystemChannels.textInput.invokeMethod('TextInput.show');
    log('Done');
  }

  //late ScrollController myScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => myConversationBloc,
      child: BlocConsumer<ConversationBloc, ConversationState>(
        listener: (context, state) {
          if (state is ConversationStateWaitingResponse) {
            myConversationList = state.conversationList;
          } else if (state is ConversationStateReady &&
              state.conversationList != null) {
            myConversationList = state.conversationList!;
          } else if (state is ConversationStateSpeaking) {
            myConversationList = state.conversationList;
          }
        },
        builder: (context, state) {
          //setFocusAndShowKeyboard(context, _focusNode);
          //_focusNode.requestFocus();
          bool isClickable = state is! ConversationStateWaitingResponse;
          if (state is ConversationStateUninitilized) {
            //FocusManager.instance.primaryFocus?.unfocus();
            BlocProvider.of<ConversationBloc>(context)
                .add(const ConversationEventInitlize());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              appBar: chatAppBar(context: context),
//########################################    body     #####################################
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<ConversationBloc, ConversationState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              log('message');
                              FocusScope.of(context).unfocus();
                            },
                            child: ListView.builder(
                              reverse: true,
                              padding:
                                  const EdgeInsets.all(30).copyWith(bottom: 8),
                              itemCount: myConversationList.length,
                              itemBuilder: (context, index) {
                                return UserMessage(
                                    message: myConversationList[
                                        myConversationList.length - index - 1]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
//##############################   Loading Icon    #############################
                    Visibility(
                      visible: (state is ConversationStateWaitingResponse),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: const SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ),

//########################################    CHAT BAR     #####################################
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          GestureDetector(
                            onLongPress: (isClickable)
                                ? () {
                                    //Start Listening
                                    if (state is ConversationStateReady) {
                                      BlocProvider.of<ConversationBloc>(context)
                                          .add(
                                              const ConversationEventStartListening());
                                    }
                                    if (state is ConversationStateSpeaking) {
                                      BlocProvider.of<ConversationBloc>(context)
                                          .add(
                                              const ConversationEventStopSpeaking());
                                      BlocProvider.of<ConversationBloc>(context)
                                          .add(
                                              const ConversationEventStartListening());
                                    }
                                  }
                                : null,
                            onLongPressEnd: (isClickable)
                                ? (details) {
                                    BlocProvider.of<ConversationBloc>(context).add(
                                        const ConversationEventStopListening());
                                    //Stop listening
                                  }
                                : null,
                            child: IconButton(
                              icon: Icon(
                                Icons.mic,
                                color: (isClickable)
                                    ? Colors.blue[500]
                                    : Colors.grey,
                              ),
                              //The mic on Hold is dealt above in the Gesture Detector
                              onPressed: null,
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    cursorColor:
                                        (state is ConversationStateListening)
                                            ? Colors.grey[100]
                                            : const Color(0xFF555555),
                                    focusNode: _focusNode,
                                    maxLines: 4,
                                    minLines: 1,
                                    controller: myTextController,
                                    decoration: InputDecoration(
                                      hintText:
                                          (state is ConversationStateListening)
                                              ? null
                                              : 'Type here...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                BlocBuilder<ConversationBloc,
                                    ConversationState>(
                                  builder: (context, state) {
                                    if (state is! ConversationStateListening) {
                                      return Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.send,
                                              color: isClickable
                                                  ? Colors.blue
                                                  : Colors.grey,
                                            ),
                                            onPressed: (isClickable)
                                                ? () {
                                                    BlocProvider.of<
                                                                ConversationBloc>(
                                                            context)
                                                        .add(
                                                      ConversationEventSendTextMessage(
                                                          myTextController
                                                              .text),
                                                    );
                                                    myTextController.clear();
                                                  }
                                                : null,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('Desliza para cancelar',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SpinKitWave(
                                            color: Colors.blue,
                                            size: 25,
                                            itemCount: 10,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

/**
 * listener: (context, state) {
          if (state is ConversationStateWaitingResponse) {
            myConversationList = state.conversationList;
          } else if (state is ConversationStateReady &&
              state.conversationList != null) {
            myConversationList = state.conversationList!;
          } else if (state is ConversationStateSpeaking) {
            myConversationList = state.conversationList;
          }
        },
 */


/**
 * 
 * GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
 */

/*
BlocBuilder<ConversationBloc, ConversationState>(
                            builder: (context, state) {
                              if (state is ConversationStateListening) {
                                return Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Desliza para cancelar',
                                            style:
                                                TextStyle(color: Colors.blue)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SpinKitWave(
                                          color: Colors.blue,
                                          size: 25,
                                          itemCount: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: myTextField,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.send,
                                          color: isClickable
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                        onPressed: (isClickable)
                                            ? () {
                                                BlocProvider.of<
                                                            ConversationBloc>(
                                                        context)
                                                    .add(
                                                  ConversationEventSendTextMessage(
                                                      myTextController.text),
                                                );
                                                myTextController.clear();
                                              }
                                            : null,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
 */