import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String? text;
  final String? uid;
  final AnimationController? animationController;

  const ChatMessage(
      {Key? key,
      @required this.text,
      @required this.uid,
      @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController!,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController!, curve: Curves.easeOut),
        child: Container(
          child: uid == '123' ? _myMessage() : _notMyChatMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:
            const EdgeInsets.only(right: 22.0, left: 48, top: 2.0, bottom: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Color(0xffE5AB50),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              topLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            )),
        child: Text(
          text!,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _notMyChatMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:
            const EdgeInsets.only(right: 48.0, left: 22, top: 2.0, bottom: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Color(0xff312923),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            )),
        child: Text(
          text!,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
