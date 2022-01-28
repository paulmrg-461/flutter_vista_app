import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:grupo_vista_app/widgets/card_service.dart';
import 'package:grupo_vista_app/widgets/headers.dart';

class ItemButton {
  final IconData icon;
  final String title;
  final Color color1;
  final Color color2;

  ItemButton(this.icon, this.title, this.color1, this.color2);
}

class ServicesTab extends StatelessWidget {
  const ServicesTab({Key? key}) : super(key: key);

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
                onPressed: () => print('Hola tolos'),
                gradientColor1: item.color1,
                gradientColor2: item.color2,
              ),
            ))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xff1B1B1B),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 210.0),
            child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(
                    height: 70.0,
                  ),
                  ...itemMap,
                  const SizedBox(
                    height: 14.0,
                  ),
                ]),
          ),
          _HeaderWidget(),
        ],
      ),
    );
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
