import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/widgets/chats_list_item.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({Key? key}) : super(key: key);

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
                    'Notificaciones',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.bell,
                    size: 36,
                    color: Color(0xffD6BA5E),
                  )
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const ChatListItem(
                      icon: FontAwesomeIcons.gavel,
                      title: 'Abogados',
                      message: 'Tienes un nuevo mensaje.',
                      date: '16 de enero de 2022 - 14:56',
                      counter: 3,
                    ),
                    const ChatListItem(
                        icon: FontAwesomeIcons.userCog,
                        title: 'Ingenieros',
                        message: 'Tienes un nuevo mensaje.',
                        date: '16 de enero de 2022 - 14:56'),
                    const ChatListItem(
                      icon: FontAwesomeIcons.handHoldingUsd,
                      title: 'Contadores',
                      message: 'Tienes un nuevo mensaje.',
                      date: '16 de enero de 2022 - 14:56',
                      counter: 5,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
