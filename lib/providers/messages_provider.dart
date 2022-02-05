import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grupo_vista_app/models/message_model.dart';

class MessagesProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  static Future<bool> sendNewMessage(MessageModel messageModel) async =>
      messages
          .add({
            'title': messageModel.title,
            'body': messageModel.body,
            'date': DateTime.now(),
            'senderId': messageModel.senderId,
            'receiverId': messageModel.receiverId,
            'seen': messageModel.seen! ? '1' : '0',
            'isProfessional': messageModel.isProfessional,
            'photoUrl': messageModel.photoUrl,
            'type': messageModel.type
          })
          .then((value) => true)
          .catchError((error) => false);

  static Stream<QuerySnapshot<MessageModel>> getAllMessages() => messages
      .where(
        'senderId',
        isEqualTo: 'co.devpaul@gmail.com',
      )
      .orderBy('date', descending: true)
      .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (messages, _) => messages.toJson())
      .snapshots();
}
