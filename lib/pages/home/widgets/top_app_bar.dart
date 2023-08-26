part of 'package:recipe_social_media/pages/home/home_page.dart';

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
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                size: 26.0,
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.person),
            )),
      ],
    );
  }
}
