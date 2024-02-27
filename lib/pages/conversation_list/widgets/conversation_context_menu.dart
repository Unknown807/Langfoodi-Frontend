part of 'conversation_list_widgets.dart';

class ConversationContextMenu extends StatelessWidget {
  const ConversationContextMenu({
    super.key,
    required this.isPinned,
    required this.isGroup,
    required this.conversationId,
    required this.child
  });

  final Widget child;
  final String conversationId;
  final bool isPinned;
  final bool isGroup;

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