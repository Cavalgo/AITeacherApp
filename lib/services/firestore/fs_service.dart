import 'package:ai_chat_voice/services/firestore/fs_provider_abstract.dart';
import 'package:ai_chat_voice/services/firestore/models/conversation_topic.dart';

class FirestoreService implements FirestoreProviderAbstract {
  final FirestoreProviderAbstract provider;

  FirestoreService({required this.provider});

  @override
  Future<List<ConversationTopic>> getConversaionAIs(
      {required String topicCategory}) {
    throw UnimplementedError();
  }

  @override
  Future<void> initilize() {
    throw UnimplementedError();
  }
}
