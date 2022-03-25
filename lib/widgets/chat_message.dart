import 'package:flutter/material.dart';
import 'package:grupo_vista_app/widgets/custom_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isProfessional;
  final String date;
  final String? downloadUrl;
  const ChatMessage(
      {Key? key,
      required this.text,
      required this.isProfessional,
      required this.date,
      required this.downloadUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isProfessional ? _notMyChatMessage(context) : _myMessage(context),
    );
  }

  Widget _myMessage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:
            const EdgeInsets.only(right: 22.0, left: 48, top: 2.0, bottom: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Color(0xff997124),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              topLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            )),
        child: downloadUrl == ""
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  (text == 'Imagen' || text == 'Imagen tomada')
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () => _downloadUrl(context, downloadUrl!),
                              child: Image(image: NetworkImage(downloadUrl!))),
                        )
                      : Container(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () => _downloadUrl(context, downloadUrl!),
                              child: Icon(
                                Icons.download_for_offline_outlined,
                                color: Colors.white60,
                                size: 72,
                              )),
                        )),
                  Text(
                    text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _notMyChatMessage(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.only(
              right: 48.0, left: 22, top: 2.0, bottom: 6.0),
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
              color: Color(0xff312923),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              )),
          child: downloadUrl == ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      date,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (text == 'Imagen' || text == 'Imagen tomada')
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () =>
                                    _downloadUrl(context, downloadUrl!),
                                child:
                                    Image(image: NetworkImage(downloadUrl!))),
                          )
                        : Container(
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: () =>
                                    _downloadUrl(context, downloadUrl!),
                                child: Icon(
                                  Icons.download_for_offline_outlined,
                                  color: Colors.white60,
                                  size: 72,
                                )),
                          )),
                    Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      date,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
    );
  }

  Future<void> _downloadUrl(BuildContext context, String url) async {
    try {
      await launch(url);
    } catch (e) {
      print(e);
      CustomAlertDialog().showCustomDialog(
          context,
          'Error al descargar',
          'Ha ocurrido un errror al descargar el archivo. Por favor intente nuevamente.',
          'Aceptar');
    }
  }
}
