import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/models/message_model.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:grupo_vista_app/providers/messages_provider.dart';
import 'package:grupo_vista_app/widgets/chats_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatsTab extends StatelessWidget {
  final UserModel? userModel;
  const ChatsTab({Key? key, @required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1B),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Conversaciones',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  FaIcon(
                    FontAwesomeIcons.edit,
                    size: 34,
                    color: Color(0xffD6BA5E),
                  )
                ],
              ),
              const SizedBox(
                height: 22.0,
              ),
              userModel!.clientEnable!
                  ? FutureBuilder<
                      Iterable<Stream<QuerySnapshot<MessageModel>>>>(
                      future: MessagesProvider.getLastMessages(userModel!),
                      builder: (context, futureSnapshot) {
                        if (futureSnapshot.hasError) {
                          return const Scaffold(
                            body: Center(
                              child: Text(
                                'Ha ocurrido un error al cargar datos, por favor intente nuevamente.',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        }
                        if (futureSnapshot.hasData) {
                          final Iterable<Stream<QuerySnapshot<MessageModel>>>
                              streamList = futureSnapshot.data as Iterable<
                                  Stream<QuerySnapshot<MessageModel>>>;
                          return Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                  children: streamList
                                      .map(
                                        (stream) => StreamBuilder<
                                            QuerySnapshot<MessageModel>>(
                                          stream: stream,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                      QuerySnapshot<
                                                          MessageModel>>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              return Center(
                                                child: Container(
                                                  width: double.infinity,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 22),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22)),
                                                  child: const Text(
                                                      'Ha ocurrido un error al cargar las solicitudes de servicio. Por favor intenta nuevamente.',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          // letterSpacing: 0.4,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              );
                                            }

                                            if (snapshot.hasData) {
                                              final List<ChatListItem>
                                                  messagesList = snapshot
                                                      .data!.docs
                                                      .map((DocumentSnapshot<
                                                              MessageModel>
                                                          document) {
                                                MessageModel messageModel =
                                                    document.data()!;
                                                return ChatListItem(
                                                    messageModel: messageModel,
                                                    userModel: userModel);
                                              }).toList();

                                              if (messagesList.isEmpty) {
                                                return Container();
                                              } else {
                                                return SingleChildScrollView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    child: Column(
                                                        children:
                                                            messagesList));
                                              }
                                            }
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Color(0xffD6BA5E),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      .toList()),
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
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
                              'A??n no cuentas con una suscripci??n activa a Vista APP. Si deseas m??s informaci??n, por favor comun??cate al n??mero 3218910268. Ten en cuenta que las solicitudes de registro pueden tardar hasta 24 horas en ser habilitadas.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  // letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
