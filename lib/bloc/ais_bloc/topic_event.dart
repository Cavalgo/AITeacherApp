class TopicEvent {}

class TopicEventGetTopics extends TopicEvent {
  final String collectionTopic;

  TopicEventGetTopics(this.collectionTopic);
}
