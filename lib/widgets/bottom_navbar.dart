part of 'custom_widgets.dart';

class BottomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.green;
  final AppBar appBar;

  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const BottomNavBar({Key? key, required this.appBar, required this.selectedIndex, this.onTap})
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
      currentIndex: selectedIndex, //New
      onTap: onTap
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

