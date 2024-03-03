part of 'app.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,

  scaffoldBackgroundColor: const Color.fromRGBO(254, 254, 254, 1),

  primaryColor: const Color.fromRGBO(49, 183, 63, 1),

  dividerColor: Colors.transparent,

  expansionTileTheme: const ExpansionTileThemeData(
    backgroundColor: Colors.transparent,
    collapsedBackgroundColor: Colors.transparent,
    iconColor: Colors.orange,
    collapsedIconColor: Colors.blueAccent,
  ),

  hintColor: Colors.grey,

  textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
  )
);

ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,

    scaffoldBackgroundColor: const Color.fromRGBO(37, 38, 39, 1),
    primaryColor: const Color.fromRGBO(49, 183, 63, 1),
    dividerColor: Colors.transparent,
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: Colors.transparent,
      collapsedBackgroundColor: Colors.transparent,
      iconColor: Colors.orange,
      collapsedIconColor: Colors.blueAccent,
    ),

    hintColor: Colors.grey,

    textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
    )
);