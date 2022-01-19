import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? _userCredentials;
  UserCredential get userCredentials => _userCredentials!;
  bool _isLogging = false;
  bool get isLogging => _isLogging;

  Future<String> login(String email, String password) async {
    _isLogging = true;
    try {
      _userCredentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String _token = await auth.currentUser!.getIdToken();

      //Save token in KeyChain - KeyStore
      await _saveToken(_token);
      await _saveUID(_userCredentials!.user!.uid);
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

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _saveUID(String token) async {
    return await _storage.write(key: 'token', value: token);
  }
}
