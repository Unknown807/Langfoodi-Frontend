import 'package:flutter/material.dart';
import 'package:recipe_social_media/custom_bottom_navbar.dart';
import 'package:recipe_social_media/custom_navbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('This is the second page!')],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('This is the third page!')],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('This is the fourth page!')],
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
      appBar: CustomNavBar(
        title: Text(widget.title),
        appBar: AppBar(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
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
