import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FatButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onPressed;
  final Color? primaryColor;
  final Color? gradientColor1;
  final Color? gradientColor2;

  const FatButton(
      {Key? key,
      @required this.icon,
      @required this.title,
      @required this.onPressed,
      this.primaryColor = Colors.white,
      this.gradientColor1 = Colors.deepPurple,
      this.gradientColor2 = Colors.purpleAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _FatButtonModel(),
        child: Builder(builder: (BuildContext context) {
          Provider.of<_FatButtonModel>(context).icon = icon!;
          Provider.of<_FatButtonModel>(context).title = title!;
          Provider.of<_FatButtonModel>(context).primaryColor = primaryColor!;
          Provider.of<_FatButtonModel>(context).gradientColor1 =
              gradientColor1!;
          Provider.of<_FatButtonModel>(context).gradientColor2 =
              gradientColor2!;
          return _FatButtonBackground(
            onPressed: onPressed,
          );
        }));
  }
}

class _FatButtonBackground extends StatelessWidget {
  final VoidCallback? onPressed;

  const _FatButtonBackground({Key? key, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fatButtonProvider = Provider.of<_FatButtonModel>(context);
    return Container(
      child: InkWell(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [_TransparentRightIcon(), _ButtonInformation()],
          ),
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.14,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(4, 6),
                blurRadius: 10.0)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          gradient: LinearGradient(colors: <Color>[
            fatButtonProvider.gradientColor1,
            fatButtonProvider.gradientColor2,
            /* Color(0xff6989F5),
            Color(0xff906EF5), */
          ])),
    );
  }
}

class _ButtonInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fatButonProvider = Provider.of<_FatButtonModel>(context);
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(
                  fatButonProvider.icon,
                  color: const Color(0xff211915),
                  size: 52.0,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  fatButonProvider.title,
                  style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff211915)),
                ),
              ],
            ),
            const FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class _TransparentRightIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fatButtonProvider = Provider.of<_FatButtonModel>(context);
    return Positioned(
      right: -20.0,
      top: -20.0,
      child: FaIcon(
        fatButtonProvider.icon,
        size: 145.0,
        color: fatButtonProvider.primaryColor.withOpacity(0.25),
      ),
    );
  }
}

class _FatButtonModel with ChangeNotifier {
  IconData _icon = FontAwesomeIcons.android;
  String _title = 'Title';
  Color _primaryColor = Colors.white;
  Color _gradientColor1 = Colors.deepPurple;
  Color _gradientColor2 = Colors.purpleAccent;

  IconData get icon => _icon;
  set icon(IconData icon) {
    _icon = icon;
  }

  String get title => _title;
  set title(String title) {
    _title = title;
  }

  Color get primaryColor => _primaryColor;
  set primaryColor(Color primaryColor) {
    _primaryColor = primaryColor;
  }

  Color get gradientColor1 => _gradientColor1;
  set gradientColor1(Color gradientColor1) {
    _gradientColor1 = gradientColor1;
  }

  Color get gradientColor2 => _gradientColor2;
  set gradientColor2(Color gradientColor2) {
    _gradientColor2 = gradientColor2;
  }
}
