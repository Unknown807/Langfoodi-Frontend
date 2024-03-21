part of 'conversation_list_widgets.dart';

class ConversationContextMenu extends StatelessWidget {
  const ConversationContextMenu({
    super.key,
    required this.isPinned,
    required this.isGroup,
    required this.isBlocked,
    required this.conversationId,
    required this.connectionId,
    required this.child
  });

  final Widget child;
  final String conversationId;
  final String connectionId;
  final bool isPinned;
  final bool isGroup;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    return ContextMenuArea(
      width: MediaQuery.of(context).size.width*0.5,
      builder: (_) => [
        ListTile(
          title: Text(isPinned ? "Unpin" : "Pin"),
          onTap: () {
            context
              .read<NavigationRepository>()
              .dismissDialog(context);

            if (isPinned) {
              context
                .read<ConversationListBloc>()
                .add(UnpinConversation(conversationId));
            } else {
              context
                .read<ConversationListBloc>()
                .add(PinConversation(conversationId));
            }
          },
        ),
        if (!isGroup && !isBlocked)
          ListTile(
            title: const Text("Block"),
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            onTap: () {
              context
                .read<NavigationRepository>()
                .dismissDialog(context);

              context
                .read<ConversationListBloc>()
                .add(BlockConnection(connectionId));
            },
          ),

        if (!isGroup && isBlocked)
          ListTile(
            title: const Text("Unblock"),
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            onTap: () {
              context
                .read<NavigationRepository>()
                .dismissDialog(context);

              context
                .read<ConversationListBloc>()
                .add(UnblockConnection(connectionId));
            },
          ),

        if (isGroup)
          ListTile(
            title: const Text("Leave Group"),
            onTap: () {
              context
                .read<NavigationRepository>()
                .dismissDialog(context);

              context
                .read<ConversationListBloc>()
                .add(LeaveGroup(conversationId));
            },
          ),
      ],
      child: child,
    );
  }
}