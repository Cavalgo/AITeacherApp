import 'models/conversation_topic.dart';

abstract class FirestoreProviderAbstract {
  //Tener un método para inizializar
  Future<void> initilize();

  Future<List<ConversationTopic>> getConversaionAIs(
      {required String topicCategory});
}
