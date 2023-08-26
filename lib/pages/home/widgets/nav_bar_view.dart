part of 'package:recipe_social_media/pages/home/home_page.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({
    super.key,
    required this.widgetPages
  });

  final List<Widget> widgetPages;

  @override
  State<StatefulWidget> createState() => NavBarViewState();
}

class NavBarViewState extends State<NavBarView> {
  int _selectedIndex = 0;
  List<Widget> get _widgetPages => widget.widgetPages;

  @override
  void initState() {
    _onItemTapped(_selectedIndex);
    super.initState();
  }

  void _onItemTapped(int index) {
    (_widgetPages[index] as PageLander).onLanding();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: const Text("Welcome"),
        appBar: AppBar(),
      ),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetPages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'My Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

