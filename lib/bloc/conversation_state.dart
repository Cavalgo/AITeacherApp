import 'package:flutter/material.dart';

@immutable
abstract class ConversationState {
  const ConversationState();
}

class ConversationStateListening extends ConversationState {
  const ConversationStateListening();
}

class ConversationStateSpeaking extends ConversationState {
  final List<Map<String, String>> conversationList;
  const ConversationStateSpeaking({
    required this.conversationList,
  });
}

class ConversationStateWaitingResponse extends ConversationState {
  final List<Map<String, String>> conversationList;
  const ConversationStateWaitingResponse({
    required this.conversationList,
  });
}

class ConversationStateUninitilized extends ConversationState {
  const ConversationStateUninitilized();
}

class ConversationStateReady extends ConversationState {
  final List<Map<String, String>>? conversationList;
  const ConversationStateReady({this.conversationList});
}
