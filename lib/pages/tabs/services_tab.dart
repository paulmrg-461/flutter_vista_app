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
      ItemButton(FontAwesomeIcons.carCrash, 'Motor Accident',
          const Color(0xff6989F5), const Color(0xff906EF5)),
      ItemButton(FontAwesomeIcons.plus, 'Medical Emergency',
          const Color(0xff66A9F2), const Color(0xff536CF6)),
      ItemButton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          const Color(0xffF2D572), const Color(0xffE06AA3)),
      ItemButton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      ItemButton(FontAwesomeIcons.carCrash, 'Motor Accident', Color(0xff6989F5),
          Color(0xff906EF5)),
      ItemButton(FontAwesomeIcons.plus, 'Medical Emergency', Color(0xff66A9F2),
          Color(0xff536CF6)),
      ItemButton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      ItemButton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      ItemButton(FontAwesomeIcons.carCrash, 'Motor Accident', Color(0xff6989F5),
          Color(0xff906EF5)),
      ItemButton(FontAwesomeIcons.plus, 'Medical Emergency', Color(0xff66A9F2),
          Color(0xff536CF6)),
      ItemButton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      ItemButton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
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
      backgroundColor: const Color(0xff211915),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 220.0),
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

class FatButtonTemp extends StatelessWidget {
  const FatButtonTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FatButton(
      icon: FontAwesomeIcons.carCrash,
      title: 'Motor Accident',
      onPressed: () => print('Hola amiguis'),
      gradientColor1: const Color(0xff6989F5),
      gradientColor2: const Color(0xff906EF5),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconHeader(
      icon: FontAwesomeIcons.plus,
      subtitle: 'You\'ve requested',
      title: 'Medical Assistance',
      color1: const Color(0xff526BF6),
      color2: const Color(0xff67ACF2),
    );
  }
}
