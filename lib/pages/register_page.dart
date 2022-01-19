import 'package:flutter/material.dart';
import 'package:grupo_vista_app/providers/user_provider.dart';
import 'package:grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:grupo_vista_app/widgets/custom_buttom.dart';
import 'package:grupo_vista_app/widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {
  final UserProvider? userProvider;
  const RegisterPage({Key? key, @required this.userProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        appBar: AppBar(
          title: const Text(
            'Quiero registrarme',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 36),
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(22)),
            child: Column(
              children: [
                CustomInput(
                  hintText: 'Nombre o razón social',
                  textController: nameController,
                  icon: Icons.person_outline,
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  borderRadius: 8,
                  backgroundColor: Colors.black54,
                  borderColor: const Color(0xffD6BA5E),
                  fontColor: Colors.white,
                ),
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
                    text: 'Registrarme',
                    width: double.infinity,
                    fontColor: const Color(0xff211915),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    backgroundColor: const Color(0xffD6BA5E),
                    onPressed: () => _register(
                        nameController.text.trim(),
                        emailController.text.trim().toLowerCase(),
                        passwordController.text.trim(),
                        context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register(
      String name, String email, String password, BuildContext context) {
    if (name == '' || email == '' || password == '') {
      CustomAlertDialog().showCustomDialog(
          context,
          'Campos vacíos',
          'Los campos no pueden estar vacíos. Por favor revise los campos e intente nuevamente',
          'Aceptar');
    } else {
      userProvider!.register(name, email, password).then((value) =>
          value == 'Registration success'
              ? Navigator.pushReplacementNamed(context, 'home')
              : CustomAlertDialog().showCustomDialog(
                  context, 'Registro incorrecto', value, 'Aceptar'));
    }
  }
}
