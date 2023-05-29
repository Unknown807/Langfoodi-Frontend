import 'package:flutter/material.dart';
import 'package:recipe_social_media/widgets/custom_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  String title = "Welcome";

  List<Widget> getPages() => [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('This is the second page!')],
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  int _selectedIndex = 0;

  void onBottomNavSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: Text(title),
        appBar: AppBar(),
      ),
      bottomNavigationBar: BottomNavBar(
          appBar: AppBar(),
          selectedIndex: _selectedIndex,
          onTap: onBottomNavSelect),
      body: Center(
          child: IndexedStack(
        index: _selectedIndex,
        alignment: Alignment.center,
        children: getPages(),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
