import 'dart:developer';

import 'package:ai_chat_voice/services/firestore/fs_provider_abstract.dart';
import 'package:ai_chat_voice/services/firestore/models/conversation_topic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider implements FirestoreProviderAbstract {
  FirebaseFirestore? _db;
  List<ConversationTopic>? _historyConversations;

  @override
  Future<List<ConversationTopic>> getConversaionAIs({
    required String topicCategory,
  }) async {
    try {
      if (_db == null) {
        await initilize();
      }

      final historyCollectionQuery =
          await _db!.collection(topicCategory).orderBy('index').get();

      final historyCollection = historyCollectionQuery.docs;
      final iterableHistoryConversationAIs = historyCollection.map((doc) {
        return ConversationTopic.fromFirestore(
          doc,
          null,
        );
      }).toList();

      return iterableHistoryConversationAIs;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<ConversationTopic>> getConversaionAIsHistory() async {
    _historyConversations ??= await getConversaionAIs(topicCategory: 'history');

    return _historyConversations!;
  }

//gs://my-ai-voice-assistant.appspot.com/topics/history/berlinwall.png
  @override
  Future<void> initilize() async {
    _db = FirebaseFirestore.instance;
  }
}
