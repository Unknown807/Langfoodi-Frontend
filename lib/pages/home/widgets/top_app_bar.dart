part of 'package:recipe_social_media/pages/home/home_page.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
    required this.title
  });

  final Color backgroundColor = const Color(0xFF02A713);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: const TextStyle(color: Colors.white),),
      backgroundColor: backgroundColor,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                size: 26.0,
                color: Colors.white
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                  Icons.more_vert,
                  color: Colors.white),
            )),
      ],
    );
  }
}
