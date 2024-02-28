part of 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';

class ReplyBoxAttachment extends StatelessWidget {
  const ReplyBoxAttachment({
    super.key,
    required this.icon,
    required this.text
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onBackground.withAlpha(150),
          size: 18
        ),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withAlpha(180)
          ),
        )
      ],
    );
  }
}