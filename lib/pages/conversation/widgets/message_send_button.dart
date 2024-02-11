part of 'conversation_widgets.dart';

class MessageSendButton extends StatelessWidget {
  const MessageSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      color: Theme.of(context).colorScheme.primary,
      icon: const Icon(Icons.send),
      onPressed: () => context
        .read<ConversationBloc>()
        .add(const SendMessage())
    );
  }
}