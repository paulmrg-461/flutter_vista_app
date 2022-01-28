import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  final String? title;
  final IconData? icon;
  const ChatPage({Key? key, @required this.title, @required this.icon})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        // appBar: _myAppBar(),
        body: Column(
          children: [
            _myAppBar(),
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            const Divider(
              height: 1,
            ),
            _inputChat()
          ],
        ),
      ),
    );
  }

  Padding _myAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              )),
          Container(
            width: 55,
            height: 55,
            margin: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              color: Color(0xffD6BA5E),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: FaIcon(
              widget.icon!,
              size: 34,
              color: const Color(0xff211915),
            )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Activo ahora',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () => print("Mira mama me aplastaron"),
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          color: const Color(0xff312923),
          borderRadius: BorderRadius.circular(36),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: IconButton(
                  icon: Icon(
                    Icons.attachment_rounded,
                    color: _isWriting
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 28,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _isWriting
                      ? () => _handleSubmit(_textController.text.trim())
                      : null),
            ),
          ),
          Flexible(
              child: TextField(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            controller: _textController,
            onSubmitted: _handleSubmit,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (String text) {
              setState(() {
                _isWriting = (text.trim().isNotEmpty) ? true : false;
              });
            },
            decoration: const InputDecoration.collapsed(
                hintText: 'Enviar mensaje...',
                hintStyle: TextStyle(color: Colors.white54)),
            focusNode: _focusNode,
          )),

          //Send button
          Container(
              margin: const EdgeInsets.only(left: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: const Text('Enviar'),
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null)
                  : IconTheme(
                      data: const IconThemeData(color: Color(0xffD6BA5E)),
                      child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: _isWriting
                                ? const Color(0xffD6BA5E)
                                : Colors.white.withOpacity(0.3),
                            size: 26,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: _isWriting
                              ? () => _handleSubmit(_textController.text.trim())
                              : null),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      uid: '1234',
      text: text,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController!.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    // TODO: Socket OFF
    for (ChatMessage message in _messages) {
      message.animationController!.dispose();
    }
    super.dispose();
  }
}
