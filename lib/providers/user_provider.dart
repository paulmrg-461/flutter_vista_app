import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:platform_device_id/platform_device_id.dart';

class UserProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? _userCredentials;
  UserCredential get userCredentials => _userCredentials!;
  bool _isLogging = false;
  bool get isLogging => _isLogging;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late FirebaseMessaging messaging;

  Future<String> login(String email, String password) async {
    _isLogging = true;
    try {
      _userCredentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String _token = await auth.currentUser!.getIdToken();

      //Save token in KeyChain - KeyStore
      await _saveToken(_token);
      await _saveUID(_userCredentials!.user!.uid);
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        _setFCMToken(value);
        print('FCMToken: $value');
        users
            .doc(_userCredentials!.user!.uid)
            .update({
              'deviceTokens': FieldValue.arrayUnion([value])
            })
            // .update({'deviceTokens': value})
            .then((value) => print("User updated"))
            .catchError((error) => print("Failed to update user: $error"));
      });
      _isLogging = false;
      return "Login success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _isLogging = false;
        return 'Usuario no encontrado, inicia el proceso de registro e intenta nuevamente.';
      } else if (e.code == 'wrong-password') {
        _isLogging = false;
        return 'Usuario o Contraseña incorrectos.';
      }
      return 'Credenciales incorrectas, por favor intenta nuevamente.';
    }
  }

  Future<String> register(String name, String email, String password) async {
    try {
      _userCredentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String _token = await auth.currentUser!.getIdToken();
      String? _deviceId = await PlatformDeviceId.getDeviceId;

      //Save token in KeyChain - KeyStore
      await _saveToken(_token);
      await _saveUID(_userCredentials!.user!.uid);

      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        _setFCMToken(value);
        print('FCMToken: $value');
        users
            .doc(_userCredentials!.user!.email)
            .set({
              'clientName': name,
              'clientEmail': email,
              'clientPhotoURL':
                  'https://forofarp.org/wp-content/uploads/2017/06/silueta-1.jpg',
              'clientEnable': false,
              'clientRegisterDate': DateTime.now(),
              'deviceId': _deviceId,
              'deviceTokens': [value]
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      });
      return "Registration success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Contraseña demasiado débil, por favor intenta nuevamente.';
      } else if (e.code == 'email-already-in-use') {
        return 'Ya existe una cuenta asociada a ese correo, por favor ingresa uno diferente.';
      }
      return 'Error en el proceso de registro, por favor intenta nuevamente.';
    }
  }

  Future<String> signInWithGoogle({required BuildContext context}) async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    String? _deviceId = await PlatformDeviceId.getDeviceId;

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        _userCredentials = await auth.signInWithCredential(credential);

        user = _userCredentials!.user;
        String _token = await auth.currentUser!.getIdToken();

        await _saveToken(_token);
        await _saveUID(_userCredentials!.user!.uid);

        messaging = FirebaseMessaging.instance;
        messaging.getToken().then((value) {
          _setFCMToken(value);
          print('FCMToken: $value');
          users
              .doc(_userCredentials!.user!.email)
              .set({
                'clientName': user!.displayName,
                'clientEmail': user.email,
                'clientPhotoURL': user.photoURL,
                'clientEnable': false,
                'clientRegisterDate': DateTime.now(),
                'deviceId': _deviceId,
                'deviceTokens': [value]
              })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        });
        return "Registration success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return 'No es posible acceder con esta cuenta debido a que se encuentra asociada a una existente, por favor intenta nuevamente.';
        } else if (e.code == 'invalid-credential') {
          return 'Credenciales incorrectas, por favor intenta nuevamente.';
        }
      } catch (e) {
        return 'Ha ocurrido un error, por favor intenta nuevamente.';
      }
    }
    return 'Ha ocurrido un error, por favor intenta nuevamente.';
  }

  Future<bool> logout() async {
    try {
      await _storage.delete(key: 'token');
      await _storage.delete(key: 'uid');
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<UserModel> getUserInformation() async {
    try {
      final userInformationRef = firestore
          .collection('users')
          .where("clientEmail", isEqualTo: auth.currentUser!.email)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (programming, _) => programming.toJson(),
          );
      QuerySnapshot querySnapshot = await userInformationRef.get();
      final List<UserModel> userInformation =
          querySnapshot.docs.map((doc) => doc.data() as UserModel).toList();

      print('TOLA');
      print(userInformation[0]);

      return userInformation[0];
    } catch (e) {
      print(e);
      return UserModel();
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _saveUID(String token) async {
    return await _storage.write(key: 'uid', value: token);
  }

  Future<void> _setFCMToken(String? token) async {
    const FlutterSecureStorage _storage = FlutterSecureStorage();
    await _storage.write(key: 'fcmToken', value: token);
  }
}
