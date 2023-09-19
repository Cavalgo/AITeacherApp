import 'dart:developer';
import 'package:ai_chat_voice/bloc/conversation_bloc/conversation_state.dart';
import 'package:ai_chat_voice/services/open_ai/openai_service.dart';
import 'package:ai_chat_voice/services/speech_to_text/speech_to_text_service.dart';
import 'package:ai_chat_voice/services/text_to_speech/text_to_speech_service.dart';
import 'package:bloc/bloc.dart';

import 'conversation_event.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
/*  SpeechToTextService mySTT;
  TextToSpeechService myTTS;
  OpenAIService myOAS;*/
  static ConversationBloc myConversationBloc = ConversationBloc._mySingletone(
    mySTT: SpeechToTextService(language: 'es-MX'),
    myTTS: TextToSpeechService(language: 'es-MX'),
    myOAS: OpenAIService(
      systemRole: 'Eres una asistente muy útil y das respuestas cortas',
    ),
  );
  List<Map<String, String>> conversationList = [
    {'role': 'system', 'message': 'Hola, en qué puedo ayudarte'},
  ];
  ConversationBloc._mySingletone({
    required SpeechToTextService mySTT,
    required TextToSpeechService myTTS,
    required OpenAIService myOAS,
  }) : super(const ConversationStateUninitilized()) {
    on<ConversationEventInitlize>((event, emit) async {
      await mySTT.initializeSpeechTT();
      await myTTS.initializeTextToSpeech();
      emit(const ConversationStateReady());
    });
    on<ConversationEventStartListening>(
      (event, emit) async {
        await mySTT.startListening();
        emit(const ConversationStateListening());
      },
    );
    on<ConversationEventStopListening>(
      (event, emit) async {
        //WE await to give the system time to catch up with the last words to recognize them
        await Future.delayed(const Duration(milliseconds: 360));
        //I don't use await here because it causes apparently a bug??
        mySTT.stopListening();
        if (mySTT.detectedWords != null) {
          conversationList.add(
            {
              'role': 'user',
              'message': mySTT.detectedWords!,
            },
          );
          emit(ConversationStateWaitingResponse(
              conversationList: conversationList));
          String response = await myOAS.sendMessageChatGPT(
            mySTT.detectedWords!,
          );
          conversationList.add(
            {
              'role': 'system',
              'message': response,
            },
          );
          emit(ConversationStateSpeaking(conversationList: conversationList));
          myTTS
              .systemSpeak(response)
              .then((value) => emit(const ConversationStateReady()));
//****SOLVE THIS ERROR*****/
          //emit(const ConversationStateReady());
        } else {
          emit(const ConversationStateReady());
        }

        //Comunicarnos con OPENAI
      },
    );
    on<ConversationEventStopSpeaking>((event, emit) async {
      emit(const ConversationStateReady());
      await myTTS.systemStopSpeaking();
    });
    on<ConversationEventCancelListening>((event, emit) async {
      await mySTT.cancelListening();
      log('lostening was cancelled');
      emit(const ConversationStateReady());
    });
    on<ConversationEventSpeakButton>((event, emit) {
      if (state is ConversationStateReady) {
        add(const ConversationEventStartListening());
      }
      if (state is ConversationStateListening) {
        add(const ConversationEventStopListening());
      }
      if (state is ConversationStateSpeaking) {
        add(const ConversationEventStopSpeaking());
        add(const ConversationEventStartListening());
      }
    });
    on<ConversationEventCancelButton>((event, emit) {
      if (state is ConversationStateListening) {
        add(const ConversationEventCancelListening());
      }
      if (state is ConversationStateSpeaking) {
        add(const ConversationEventStopSpeaking());
      }
    });
    on<ConversationEventSendTextMessage>((event, emit) async {
      conversationList.add(
        {
          'role': 'user',
          'message': event.message,
        },
      );
      emit(
        ConversationStateWaitingResponse(conversationList: conversationList),
      );
      String response = await myOAS.sendMessageChatGPT(event.message);
      conversationList.add(
        {
          'role': 'system',
          'message': response,
        },
      );
      emit(ConversationStateReady(conversationList: conversationList));
    });
  }
}

//on<>((event, emit) {});
