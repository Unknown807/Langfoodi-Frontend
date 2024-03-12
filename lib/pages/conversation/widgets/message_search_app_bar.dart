part of 'conversation_widgets.dart';

class MessageSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessageSearchAppBar({
    super.key,
    required this.isGroup,
    required this.isBlocked,
    required this.conversationName,
    required this.thumbnailId
  });

  final bool isGroup;
  final bool isBlocked;
  final String conversationName;
  final String? thumbnailId;

  @override
  Widget build(BuildContext context) {
    return CustomSearchAppBar(
      title: Row(
        children: [
          CustomCircleAvatar(
            avatarIcon: isGroup ? Icons.group : Icons.person,
            avatarIconSize: 25,
            thumbnailBoxHeight: 40,
            thumbnailBoxWidth: 37,
            thumbnailId: thumbnailId,
            conversationStatus: isBlocked ? ConversationStatus.blocked : null,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(conversationName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground)
            )
          ),
        ],
      ),
      onSearchFunc: (term) => context
        .read<ConversationBloc>()
        .add(SearchMessages(term))
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}