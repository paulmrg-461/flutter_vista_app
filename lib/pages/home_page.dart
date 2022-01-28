import 'package:flutter/material.dart';
import 'package:grupo_vista_app/pages/tabs/chats_tab.dart';
import 'package:grupo_vista_app/pages/tabs/notifications_tab.dart';
import 'package:grupo_vista_app/pages/tabs/profile_tab.dart';
import 'package:grupo_vista_app/pages/tabs/services_tab.dart';
import 'package:grupo_vista_app/widgets/custom_animated_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final Color _inactiveColor = Colors.grey;
  final Color _activeColor = const Color(0xffD6BA5E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(),
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.black,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(Icons.group),
          title: const Text('Servicios'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.message),
          title: const Text(
            'Mensajes ',
          ),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.notifications),
          title: const Text('Notificaciones'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Perfil'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const ServicesTab(),
      const ChatsTab(),
      const NotificationsTab(),
      const ProfileTab()
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
