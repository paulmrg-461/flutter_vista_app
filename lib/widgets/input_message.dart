import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/models/message_model.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:grupo_vista_app/providers/messages_provider.dart';

class InputMessage extends StatefulWidget {
  final UserModel? userModel;
  final MessageModel? messageModel;
  const InputMessage({
    Key? key,
    @required this.userModel,
    @required this.messageModel,
  }) : super(key: key);

  @override
  _InputMessageState createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage>
    with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isLoading = false;
  bool _isWriting = false;
  bool _isChoosing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: _isChoosing
            ? Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20, top: 8),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.75),
                          offset: const Offset(5, 7),
                          blurRadius: 20.0)
                    ],
                    color: const Color(0xff312923),
                    borderRadius: BorderRadius.circular(22)),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      setState(() => _isChoosing = false),
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Cancelar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _uploadAttachment(['jpg'], 'Imagen'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Camera',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _uploadAttachment(['jpg'], 'Imagen'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.photoVideo,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Gallery',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => _uploadAttachment(
                                      ['pdf', 'doc'], 'Documento'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.file,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('File',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => print('Microphone'),
                                  icon: FaIcon(
                                    FontAwesomeIcons.microphone,
                                    color: Colors.white70,
                                    size: 34,
                                  )),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Record',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        ],
                      ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: const Color(0xff312923),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, 5),
                          blurRadius: 5)
                    ]),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20, top: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: IconTheme(
                        data: const IconThemeData(color: Colors.white),
                        child: IconButton(
                            icon: Icon(
                              Icons.attachment_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () =>
                                setState(() => _isChoosing = true)),
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
                                    ? () => _handleSubmit(
                                        _textController.text.trim())
                                    : null)
                            : IconTheme(
                                data: const IconThemeData(
                                    color: Color(0xffD6BA5E)),
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
                                        ? () => _handleSubmit(
                                            _textController.text.trim())
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
    MessageModel messageModel = MessageModel(
        userName: widget.messageModel!.userName,
        professionalName: widget.messageModel!.professionalName,
        userEmail: widget.messageModel!.userEmail,
        professionalEmail: widget.messageModel!.professionalEmail,
        userPhotoUrl: widget.messageModel!.userPhotoUrl,
        professionalPhotoUrl: widget.messageModel!.professionalPhotoUrl,
        message: text,
        isProfessional: false,
        seen: false,
        type: widget.messageModel!.type,
        senderId: widget.userModel!.clientEmail,
        date: DateTime.now(),
        receiverId: widget.messageModel!.professionalEmail);
    MessagesProvider.sendNewMessage(messageModel);
    // final newMessage = ChatMessage(
    //   uid: '123',
    //   text: text,
    //   animationController: AnimationController(
    //       vsync: this, duration: const Duration(milliseconds: 300)),
    // );
    // _messages.insert(0, newMessage);
    // newMessage.animationController!.forward();

    setState(() {
      _isWriting = false;
    });
  }

  Future<void> _uploadAttachment(List<String> fileTypes, String message) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: fileTypes,
    );

    setState(() => _isLoading = true);

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileExtension = result.files.single.extension!;

      final String downloadUrl = await MessagesProvider.uploadFile(file,
          'messages/${widget.userModel!.clientEmail}/${DateTime.now()}.$fileExtension');

      MessageModel messageModel = MessageModel(
          userName: widget.messageModel!.userName,
          professionalName: widget.messageModel!.professionalName,
          userEmail: widget.messageModel!.userEmail,
          professionalEmail: widget.messageModel!.professionalEmail,
          userPhotoUrl: widget.messageModel!.userPhotoUrl,
          downloadUrl: downloadUrl,
          professionalPhotoUrl: widget.messageModel!.professionalPhotoUrl,
          message: message,
          isProfessional: false,
          seen: false,
          type: widget.messageModel!.type,
          senderId: widget.userModel!.clientEmail,
          date: DateTime.now(),
          receiverId: widget.messageModel!.professionalEmail);
      MessagesProvider.sendNewMessage(messageModel);
      setState(() {
        _isLoading = false;
        _isChoosing = false;
      });
    } else {
      // User canceled the picker
      setState(() {
        _isChoosing = false;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
