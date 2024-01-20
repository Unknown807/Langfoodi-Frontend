part of 'package:recipe_social_media/pages/home/home_page.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({
    super.key,
    required this.widgetPages,
    required this.onLandOnce
  });

  final List<Widget> widgetPages;
  final List<bool> onLandOnce;

  @override
  State<StatefulWidget> createState() => NavBarViewState();
}

class NavBarViewState extends State<NavBarView> {
  int _selectedIndex = 0;
  List<bool> _landed = [];
  List<Widget> get _widgetPages => widget.widgetPages;
  List<bool> get _onLandOnce => widget.onLandOnce;

  @override
  void initState() {
    _landed = List.generate(widget.widgetPages.length, (index) => false);
    _onItemTapped(_selectedIndex);
    super.initState();
  }

  void _onItemTapped(int index) {
    if ((_onLandOnce[index] && !_landed[index]) || !_onLandOnce[index]) {
      (_widgetPages[index] as PageLander).onLanding(context);
    }

    setState(() {
      _selectedIndex = index;
      _landed[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.background,
        onTap: _onItemTapped,
      ),
    );
  }
}
