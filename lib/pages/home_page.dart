import 'package:flutter/material.dart';
import 'package:grupo_vista_app/models/user_model.dart';
import 'package:grupo_vista_app/pages/tabs/chats_tab.dart';
import 'package:grupo_vista_app/pages/tabs/profile_tab.dart';
import 'package:grupo_vista_app/pages/tabs/services_tab.dart';
import 'package:grupo_vista_app/providers/user_provider.dart';
import 'package:grupo_vista_app/widgets/custom_animated_bottom_bar.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';

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
    final UserProvider _userProvider = Provider.of<UserProvider>(context);
    return FutureBuilder<UserModel>(
        future: _getUserInformation(_userProvider),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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
          if (snapshot.hasData) {
            final UserModel _userModel = snapshot.data as UserModel;
            return Scaffold(
              body: getBody(_userModel),
              bottomNavigationBar: _buildBottomBar(),
            );
          }
          return const Scaffold(
            backgroundColor: Color(0xff211915),
            body: Center(child: CircularProgressIndicator()),
          );
        });
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
          icon: const Icon(Icons.person),
          title: const Text('Perfil'),
          activeColor: _activeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody(UserModel _userModel) {
    List<Widget> pages = [
      ServicesTab(userModel: _userModel),
      ChatsTab(userModel: _userModel),
      ProfileTab(
        userModel: _userModel,
      )
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Future<UserModel> _getUserInformation(UserProvider _userProvider) async {
    String? _deviceId = await PlatformDeviceId.getDeviceId;
    final UserModel userModel = await _userProvider.getUserInformation();
    print(userModel.deviceId);
    (_deviceId == userModel.deviceId || userModel.deviceId == 'test')
        ? print('User active')
        : await _userProvider.logout().then((value) => value
            ? Navigator.pushReplacementNamed(context, 'login')
            : print('Logout error'));
    return userModel;
  }
}
