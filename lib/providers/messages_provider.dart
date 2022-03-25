import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:grupo_vista_app/models/message_model.dart';
import 'package:grupo_vista_app/models/professional_model.dart';
import 'package:grupo_vista_app/models/user_model.dart';

class MessagesProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  static CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  static CollectionReference professionals =
      FirebaseFirestore.instance.collection('professionals');

  static Future<Iterable<Stream<QuerySnapshot<MessageModel>>>> getLastMessages(
          UserModel userModel) =>
      professionals
          .withConverter<ProfessionalModel>(
              fromFirestore: (snapshot, _) =>
                  ProfessionalModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .get()
          .then((usr) => usr.docs.map((doc) {
                final ProfessionalModel professionalModel = doc.data();
                return FirebaseFirestore.instance
                    .doc('messages/${userModel.clientEmail}')
                    .collection('userMessages')
                    .where('professionalEmail',
                        isEqualTo: professionalModel.email)
                    .orderBy('date', descending: true)
                    .limit(1)
                    .withConverter<MessageModel>(
                        fromFirestore: (snapshot, _) =>
                            MessageModel.fromJson(snapshot.data()!),
                        toFirestore: (messages, _) => messages.toJson())
                    .snapshots();
              }));

  static Stream<QuerySnapshot<MessageModel>> getChatroomMessages(
          MessageModel messageModel) =>
      FirebaseFirestore.instance
          .doc('messages/${messageModel.userEmail}')
          .collection('userMessages')
          .where('professionalEmail', isEqualTo: messageModel.professionalEmail)
          .where('userEmail', isEqualTo: messageModel.userEmail)
          .orderBy('date', descending: true)
          .withConverter<MessageModel>(
              fromFirestore: (snapshot, _) =>
                  MessageModel.fromJson(snapshot.data()!),
              toFirestore: (messages, _) => messages.toJson())
          .snapshots();

  static void sendNewMessage(MessageModel messageModel) => messages
      .doc(messageModel.userEmail)
      .collection('userMessages')
      .add(messageModel.toJson());

  static Future<String> uploadFile(File file, String path) async {
    try {
      final firebase_storage.TaskSnapshot taskSnapshot =
          await storage.ref(path).putFile(file);

      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
      return 'Error';
    }
  }
}
