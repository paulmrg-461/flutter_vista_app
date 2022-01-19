import 'package:flutter/material.dart';
import 'package:grupo_vista_app/pages/chat_page.dart';
import 'package:grupo_vista_app/pages/home_page.dart';
import 'package:grupo_vista_app/pages/login_page.dart';
import 'package:grupo_vista_app/pages/register_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => HomePage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'chat': (_) => const ChatPage(),
};
