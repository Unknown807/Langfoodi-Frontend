part of 'conversation_widgets.dart';

class MessageSendButton extends StatelessWidget {
  const MessageSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (p, c) =>
        p.sendingMessage != c.sendingMessage
        || p.pageLoading != c.pageLoading
        || p.isBlocked != c.isBlocked,
      builder: (context, state) {
        return IconButton(
          splashRadius: 20,
          color: Theme.of(context).colorScheme.primary,
          disabledColor: Theme.of(context).hintColor,
          icon: const Icon(Icons.send),
          onPressed: state.sendingMessage || state.pageLoading || state.isBlocked ? null : () => context
            .read<ConversationBloc>()
            .add(const SendMessage())
        );
      },
    );
  }
}