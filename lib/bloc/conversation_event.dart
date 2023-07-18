import 'package:flutter/material.dart';

@immutable
abstract class ConversationEvent {
  const ConversationEvent();
}

class ConversationEventStartListening extends ConversationEvent {
  const ConversationEventStartListening();
}

class ConversationEventStopListening extends ConversationEvent {
  const ConversationEventStopListening();
}

class ConversationEventStartSpeaking extends ConversationEvent {
  const ConversationEventStartSpeaking();
}

class ConversationEventStopSpeaking extends ConversationEvent {
  const ConversationEventStopSpeaking();
}

class ConversationEventInitlize extends ConversationEvent {
  const ConversationEventInitlize();
}

class ConversationEventCancelListening extends ConversationEvent {
  const ConversationEventCancelListening();
}

class ConversationEventSpeakButton extends ConversationEvent {
  const ConversationEventSpeakButton();
}

class ConversationEventCancelButton extends ConversationEvent {
  const ConversationEventCancelButton();
}

class ConversationEventSendTextMessage extends ConversationEvent {
  String message;
  ConversationEventSendTextMessage(this.message);
}
