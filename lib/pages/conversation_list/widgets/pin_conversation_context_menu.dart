part of 'conversation_list_widgets.dart';

class PinConversationContextMenu extends StatelessWidget {
  const PinConversationContextMenu({
    super.key,
    required this.isPinned,
    required this.conversationId,
    required this.child
  });

  final Widget child;
  final String conversationId;
  final bool isPinned;

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
      ],
      child: child,
    );
  }
}