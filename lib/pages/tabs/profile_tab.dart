import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:grupo_vista_app/providers/user_provider.dart';
import 'package:grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  final UserModel? userModel;
  const ProfileTab({Key? key, @required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider _userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mi perfil',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.user,
                    size: 34,
                    color: Color(0xffD6BA5E),
                  )
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: const Color(0xffD6BA5E),
                        border: Border.all(color: Colors.white, width: 5.0),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(userModel!.clientPhotoURL!))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel!.clientName!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              userModel!.clientEmail!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                    color: userModel!.clientEnable!
                                        ? Colors.green.withOpacity(0.8)
                                        : Colors.red.withOpacity(0.8),
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                userModel!.clientEnable!
                                    ? 'Usuario Grupo Vista'
                                    : 'Usuario inactivo',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.85),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      tooltip: 'Cerrar sesión',
                      onPressed: () => _userProvider.logout().then((value) => value
                          ? Navigator.pushReplacementNamed(context, 'login')
                          : CustomAlertDialog().showCustomDialog(
                              context,
                              'Ha ocurrido un error',
                              'Ha ocurrido un error al cerrar sesión, por favor intente nuevamente.',
                              'Aceptar')),
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xffD6BA5E),
                        size: 36,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
