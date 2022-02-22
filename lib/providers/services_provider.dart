import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grupo_vista_app/models/user_model.dart';

class ServicesProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference serviceRequests =
      FirebaseFirestore.instance.collection('serviceRequests');

  static Future<bool> createServiceRequest(
          UserModel userModel, String type) async =>
      serviceRequests
          .doc('$type|${userModel.clientEmail}')
          .set({
            'dateTime': DateTime.now(),
            'name': userModel.clientName,
            'email': userModel.clientEmail,
            'photoUrl': userModel.clientPhotoURL,
            'type': type
          })
          .then((value) => true)
          .catchError((error) => false);
}
