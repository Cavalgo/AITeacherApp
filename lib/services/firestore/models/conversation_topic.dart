import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationTopic {
  final String title;
  final String description;
  final String pictureLink;
  final String pictureLocation;

  final int index;

  ConversationTopic({
    required this.title,
    required this.description,
    required this.pictureLink,
    required this.pictureLocation,
    required this.index,
  });

  factory ConversationTopic.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ConversationTopic(
      title: data['title'],
      description: data['description'],
      pictureLink: data['pictureLink'],
      pictureLocation: data['pictureLocation'],
      index: data['index'],
    );
  }
}
