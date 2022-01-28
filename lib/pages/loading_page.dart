import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';
import 'login_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B1B1B),
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logo_grupo_vista.svg',
                  semanticsLabel: 'Logo Grupo Vista',
                  width: MediaQuery.of(context).size.height * 0.175,
                ),
                const Text(
                  'Cargando...',
                  style: TextStyle(
                      color: Color(0xffD6BA5E),
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    const _storage = FlutterSecureStorage();
    final authenticated = await _storage.read(key: 'token');

    if (authenticated == null || authenticated == '') {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: const Duration(milliseconds: 150)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomePage(),
              transitionDuration: const Duration(milliseconds: 150)));
    }
  }
}
