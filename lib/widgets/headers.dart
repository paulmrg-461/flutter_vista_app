import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurvedHeader extends StatelessWidget {
  const CurvedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      //color: Color(0xff615AAB),
      child: CustomPaint(
        painter: _CurvedHeaderPainter(),
      ),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    //Properties
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    //paint.style = PaintingStyle.stroke;
    //paint.strokeWidth = 20.0;

    final path = Path();
    //Draw with the path and paint
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.45, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaveHeader extends StatelessWidget {
  const WaveHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      //color: Color(0xff615AAB),
      child: CustomPaint(
        painter: _WaveHeaderPainter(),
      ),
    );
  }
}

class _WaveHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    //Properties
    paint.color = Color(0xff615AAB);
    paint.style = PaintingStyle.fill;
    //paint.style = PaintingStyle.stroke;
    //paint.strokeWidth = 20.0;

    final path = Path();
    //Draw with the path and paint
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35,
        size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.25, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class IconHeader extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final Color? color1;
  final Color? color2;

  IconHeader({
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    this.color1 = Colors.deepPurpleAccent,
    this.color2 = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    final Color whiteColor = const Color(0xff211915).withOpacity(0.8);
    return Stack(
      children: [
        _IconHeaderBackground(color1: color1!, color2: color2!),
        Positioned(
          top: -50,
          left: -70,
          child: FaIcon(
            icon!,
            size: 250.0,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 80.0,
              width: double.infinity,
            ),
            Text(
              subtitle!,
              style: TextStyle(fontSize: 22, color: whiteColor),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Text(
              title!,
              style: TextStyle(
                  fontSize: 32, color: whiteColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 22.0,
            ),
            SvgPicture.asset(
              'assets/icons/logo_grupo_vista_black.svg',
              semanticsLabel: 'Logo Grupo Vista',
              height: 110,
            )
            // FaIcon(
            //   icon!,
            //   size: 80.0,
            //   color: Colors.white,
            // ),
          ],
        )
      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color? color1;
  final Color? color2;
  const _IconHeaderBackground({
    @required this.color1,
    @required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(90.0)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[color1!, color2!])),
    );
  }
}
