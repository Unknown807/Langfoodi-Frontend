part of 'package:recipe_social_media/pages/profile_settings/profile_settings_page.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
    required this.title
  });

  final Color backgroundColor = Colors.green;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      backgroundColor: backgroundColor,
      leading: GestureDetector(
              onTap: () {Navigator.pop(context);},
              child: const Icon(
                Icons.arrow_back,
              ),
            )
      ,
    );
  }
}
