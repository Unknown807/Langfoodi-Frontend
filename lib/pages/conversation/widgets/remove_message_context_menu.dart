part of 'conversation_widgets.dart';

class RemoveMessageContextMenu extends StatelessWidget {
  const RemoveMessageContextMenu({
    super.key,
    required this.messageId,
    required this.child
  });

  final String messageId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ContextMenuArea(
      width: MediaQuery.of(context).size.width*0.5,
      builder: (_) => [
        BlocProvider<ConversationBloc>.value(
          value: BlocProvider.of<ConversationBloc>(context),
          child: ListTile(
            title: const Text("Remove"),
            onTap: () {
              context.read<NavigationRepository>().dismissDialog(context);
              showDialog(
                context: context,
                builder: (_) => BlocProvider<ConversationBloc>.value(
                  value: BlocProvider.of<ConversationBloc>(context),
                  child: CustomAlertDialog(
                    title: const Text("Remove Message"),
                    content: const Text("Are you sure you want to remove this message?"),
                    rightButtonCallback: () => context
                      .read<ConversationBloc>()
                      .add(RemoveMessage(messageId))
                  ),
                )
              );
            }
          ),
        )
      ],
      child: child,
    );
  }
}