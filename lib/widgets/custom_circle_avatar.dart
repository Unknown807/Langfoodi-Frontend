part of 'shared_widgets.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.avatarIcon,
    this.avatarIconSize = 30,
    this.statusIconSize = 20,
    this.conversationStatus,
    this.statusIcon
  });

  final IconData avatarIcon;
  final double avatarIconSize;
  final double statusIconSize;
  final Icon? statusIcon;
  final ConversationStatus? conversationStatus;

  Widget getStatusIcon(ConversationStatus? conversationStatus, ThemeData themeData) {
    switch (conversationStatus) {
      case ConversationStatus.blocked:
        return Icon(
          Icons.block,
          color: themeData.colorScheme.inversePrimary,
          size: statusIconSize,
        );
      case ConversationStatus.pending:
        return Icon(
          Icons.pending,
          color: themeData.colorScheme.tertiary.withGreen(180),
          size: statusIconSize,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
            backgroundColor: const Color.fromRGBO(106, 113, 117, 1),
            child: Icon(
              avatarIcon,
              color: const Color.fromRGBO(207, 212, 214, 1),
              size: avatarIconSize,
            )
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 8, color: Colors.white, style: BorderStyle.solid),
                    ),
                  ),
                ),
                statusIcon ?? getStatusIcon(conversationStatus, Theme.of(context))
              ]
          ),
        )
      ],
    );
  }
}