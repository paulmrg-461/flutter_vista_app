import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grupo_vista_app/pages/chat_page.dart';

class ChatListItem extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? message;
  final String? date;
  final int? counter;
  const ChatListItem(
      {Key? key,
      @required this.icon,
      @required this.title,
      @required this.message,
      @required this.date,
      this.counter = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                title: title,
                icon: icon,
                receiverEmail: 'nestor.botina@grupovista.co',
              ),
            )),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xffD6BA5E),
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: FaIcon(
                icon!,
                size: 42,
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
                      title!,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        message!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      date!,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            counter == 0
                ? Container()
                : Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xffD6BA5E),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      '$counter',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
          ],
        ),
      ),
    );
  }
}
