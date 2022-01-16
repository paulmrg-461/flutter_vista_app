import 'package:flutter/material.dart';
import 'package:grupo_vista_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vista App',
      routes: appRoutes,
      initialRoute: 'login',
      theme: ThemeData(
        // brightness: Brightness.light,
        primaryColor: const Color(0xff211915),
        colorScheme: theme.colorScheme.copyWith(
            primary: const Color(0xffD6BA5E),
            secondary: const Color(0xffD6BA5E)),
        appBarTheme: const AppBarTheme(
            color: Color(0xff1B1B1B), centerTitle: true, elevation: 1.5),
      ),
    );
  }
}
