import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.green;
  final AppBar appBar;

  const CustomBottomNavBar({Key? key, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'My creations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

