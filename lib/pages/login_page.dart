import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grupo_vista_app/widgets/custom_buttom.dart';
import 'package:grupo_vista_app/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black54,
        backgroundColor: const Color(0xff211915),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Bienvenido a Vista App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 18,
                    ),
                    SvgPicture.asset(
                      'assets/icons/logo_grupo_vista.svg',
                      semanticsLabel: 'Logo Grupo Vista',
                      width: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 42, horizontal: 36),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    children: [
                      CustomInput(
                        hintText: 'Correo electrónico',
                        textController: emailController,
                        icon: Icons.email_outlined,
                        textInputType: TextInputType.emailAddress,
                        borderRadius: 8,
                        backgroundColor: Colors.black54,
                        borderColor: const Color(0xffD6BA5E),
                        fontColor: Colors.white,
                      ),
                      CustomInput(
                        hintText: 'Contraseña',
                        textController: passwordController,
                        icon: Icons.lock_outline_rounded,
                        obscureText: true,
                        passwordVisibility: true,
                        borderRadius: 8,
                        backgroundColor: Colors.black54,
                        borderColor: const Color(0xffD6BA5E),
                        fontColor: Colors.white,
                      ),
                      CustomButton(
                          text: 'Iniciar sesión',
                          width: double.infinity,
                          fontColor: const Color(0xff211915),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          backgroundColor: const Color(0xffD6BA5E),
                          onPressed: () => print('Mira mama, me aplastaron')),
                      const _GoogleButton(),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('¿Eres nuevo?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, 'register'),
                              child: const Text('Regístrate',
                                  style: TextStyle(
                                      color: Color(0xffD6BA5E),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(22)),
                  child: const Text(
                      'Somos una oficina virtual donde encontrarás asesoría y acompañamiento de diferentes profesionales como abogados, contadores, ingenieros, administradores de empresas y asesores en el área que requieras, sin necesidad de moverte de tu casa o empresa, afíliate al GRUPO VISTA.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          // letterSpacing: 0.4,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith((states) =>
                  states.contains(MaterialState.pressed)
                      ? const Color(0xffD6BA5E).withOpacity(0.5)
                      : null),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
                // side: BorderSide(color: Colors.red)
              ))),
          onPressed: () => 'Mira mama, me aplastaron el Google',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(7),
                width: 30,
                height: 30,
                child: Image.asset('assets/icons/google_logo.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Iniciar con Google',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff211915),
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
