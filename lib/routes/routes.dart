import 'package:flutter/material.dart';
import 'package:grupo_vista_app/pages/home_page.dart';
import 'package:grupo_vista_app/pages/loading_page.dart';
import 'package:grupo_vista_app/pages/login_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomePage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage(),
};
