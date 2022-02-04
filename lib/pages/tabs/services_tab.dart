import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:grupo_vista_app/providers/services_provider.dart';
import 'package:grupo_vista_app/widgets/card_service.dart';
import 'package:grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:grupo_vista_app/widgets/headers.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemButton {
  final IconData icon;
  final String title;
  final Color color1;
  final Color color2;

  ItemButton(this.icon, this.title, this.color1, this.color2);
}

class ServicesTab extends StatelessWidget {
  final UserModel? userModel;
  const ServicesTab({Key? key, @required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <ItemButton>[
      ItemButton(FontAwesomeIcons.gavel, 'Abogados', const Color(0xffD6BA5E),
          const Color(0xff9D7628)),
      ItemButton(FontAwesomeIcons.userCog, 'Ingenieros',
          const Color(0xffD6BA5E), const Color(0xff9D7628)),
      ItemButton(FontAwesomeIcons.handHoldingUsd, 'Contadores',
          const Color(0xffD6BA5E), const Color(0xff9D7628)),
      ItemButton(FontAwesomeIcons.briefcase, 'Administradores',
          const Color(0xffD6BA5E), const Color(0xff9D7628)),
    ];

    List<Widget> itemMap = items
        .map((item) => FadeInLeft(
              duration: const Duration(milliseconds: 350),
              child: FatButton(
                icon: item.icon,
                title: item.title,
                onPressed: () => ServicesProvider.createServiceRequest(
                        userModel!, item.title)
                    .then((value) => value
                        ? CustomAlertDialog().showCustomDialog(
                            context,
                            'Solicitud creada exitosamente',
                            'La solicitud del servicio de ${item.title} ha sido creada exitosamente. En un momento uno de nuestros profesionales se comunicará contigo.',
                            'Aceptar')
                        : CustomAlertDialog().showCustomDialog(
                            context,
                            'Error al realizar solicitud',
                            'Ha ocurrido un error al intentar solicitar el servicio de ${item.title}. Por favor intenta nuevamente.',
                            'Aceptar')),
                gradientColor1: item.color1,
                gradientColor2: item.color2,
              ),
            ))
        .toList();

    return Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: userModel!.clientEnable!
            ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.22),
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.065,
                          ),
                          ...itemMap,
                          const SizedBox(
                            height: 14.0,
                          ),
                        ]),
                  ),
                  _HeaderWidget(),
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () => launch("tel://3218910268"),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(22)),
                    child: const Text(
                        'Aún no cuentas con una suscripción activa a Vista APP. Si deseas más información, por favor comunícate al número 3218910268. Ten en cuenta que las solicitudes de registro pueden tardar hasta 24 horas en ser habilitadas.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            // letterSpacing: 0.4,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ));
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const IconHeader(
      icon: FontAwesomeIcons.globe,
      subtitle: 'Grupo Vista',
      title: 'Servicios disponibles',
      color1: Color(0xff694706),
      color2: Color(0xffD6BA5E),
    );
  }
}
