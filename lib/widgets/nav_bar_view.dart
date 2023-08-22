part of 'custom_widgets.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({super.key});

  @override
  State<StatefulWidget> createState() => NavBarViewState();
}

class NavBarViewState extends State<NavBarView> {
  int _selectedIndex = 0;
  final List<Widget> _widgetPages = <Widget>[
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('This is the home page')],
    ),
    const Column(
      children: <Widget>[RecipeViewPage()],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('This is the third page!')],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text('This is the fourth page!')],
    ),
  ];

  void _onItemTapped(int index) {
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
          alignment: Alignment.center,
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
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

