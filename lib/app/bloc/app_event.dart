part of 'package:recipe_social_media/app/app.dart';

@immutable
sealed class AppEvent {
  const AppEvent();
}

final class InitState extends AppEvent {
  const InitState();
}

final class ChangeAppTheme extends AppEvent {
  const ChangeAppTheme();
}