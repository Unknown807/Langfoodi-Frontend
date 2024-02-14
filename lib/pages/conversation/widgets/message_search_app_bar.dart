part of 'conversation_widgets.dart';

class MessageSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessageSearchAppBar({
    super.key,
    required this.isGroup,
    required this.conversationName
  });

  final bool isGroup;
  final String conversationName;

  @override
  Widget build(BuildContext context) {
    return CustomSearchAppBar(
      title: Row(
        children: [
          CustomCircleAvatar(
            avatarIcon: isGroup ? Icons.group : Icons.person,
            //TODO: status will be refactored eventually
            //conversationStatus: convo.conversationStatus,
            avatarIconSize: 25,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(conversationName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
            )
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {print("more options pressed");},
        )
      ],
      onSearchFunc: (term) => context
        .read<ConversationBloc>()
        .add(SearchMessages(term))
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}