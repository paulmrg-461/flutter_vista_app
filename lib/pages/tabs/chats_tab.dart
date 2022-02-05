import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/models/message_model.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:grupo_vista_app/providers/messages_provider.dart';
import 'package:grupo_vista_app/widgets/chats_list_item.dart';

class ChatsTab extends StatelessWidget {
  final UserModel? userModel;
  const ChatsTab({Key? key, @required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    'Conversaciones',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.edit,
                    size: 34,
                    color: Color(0xffD6BA5E),
                  )
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),

              StreamBuilder<QuerySnapshot<MessageModel>>(
                stream: MessagesProvider.getAllMessages(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<MessageModel>> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(22)),
                        child: const Text(
                            'Ha ocurrido un error al cargar las conversaciones. Por favor intenta nuevamente.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                // letterSpacing: 0.4,
                                fontWeight: FontWeight.w400)),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffD6BA5E),
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot<MessageModel> document) {
                          MessageModel message = document.data()!;
                          return ChatListItem(
                              icon: FontAwesomeIcons.gavel,
                              title: message.title,
                              message: message.body,
                              date: '${message.date}',
                              userModel: userModel);
                        }).toList(),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffD6BA5E),
                    ),
                  );
                },
              ),

              // Expanded(
              //     child: SingleChildScrollView(
              //   physics: const BouncingScrollPhysics(),
              //   child: Column(
              //     children: [
              //       ChatListItem(
              //         icon: FontAwesomeIcons.gavel,
              //         title: 'Abogados',
              //         message: 'Hola, necesito un servicio con el Grupo Vista',
              //         date: '16 de enero de 2022 - 14:56',
              //         counter: 3,
              //         userModel: userModel,
              //       ),
              //       ChatListItem(
              //         icon: FontAwesomeIcons.userCog,
              //         title: 'Ingenieros',
              //         message: 'Hola, necesito un servicio con el Grupo Vista',
              //         date: '16 de enero de 2022 - 14:56',
              //         userModel: userModel,
              //       ),
              //       ChatListItem(
              //           icon: FontAwesomeIcons.handHoldingUsd,
              //           title: 'Contadores',
              //           message:
              //               'Hola, necesito un servicio con el Grupo Vista',
              //           date: '16 de enero de 2022 - 14:56',
              //           counter: 5,
              //           userModel: userModel),
              //     ],
              //   ),
              // ))
            ],
          ),
        ),
      ),
    );
  }
}
