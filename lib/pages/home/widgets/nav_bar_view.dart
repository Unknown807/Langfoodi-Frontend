part of 'package:recipe_social_media/pages/home/home_page.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({
    super.key,
    required this.widgetPages,
    required this.pageTitles
  });

  final List<Widget> widgetPages;
  final List<String> pageTitles;

  @override
  State<StatefulWidget> createState() => NavBarViewState();
}

class NavBarViewState extends State<NavBarView> {
  int _selectedIndex = 0;
  String _selectedTitle = "";

  List<Widget> get _widgetPages => widget.widgetPages;
  List<String> get _pageTitles => widget.pageTitles;

  @override
  void initState() {
    _onItemTapped(_selectedIndex);
    super.initState();
  }

  void _onItemTapped(int index) {
    (_widgetPages[index] as PageLander).onLanding(context);
    setState(() {
      _selectedIndex = index;
      _selectedTitle = _pageTitles[_selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: TopAppBar(title: _selectedTitle)),
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
                icon: Icon(Icons.chat),
                label: 'Conversations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'My Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
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
