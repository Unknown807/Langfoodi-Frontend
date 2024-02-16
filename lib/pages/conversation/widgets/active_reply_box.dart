part of 'conversation_widgets.dart';

class ActiveReplyBox extends StatelessWidget {
  const ActiveReplyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (p, c) =>
        p.repliedMessage.id != c.repliedMessage.id
        || p.repliedMessageIsSentByMe != c.repliedMessageIsSentByMe,
      builder: (context, state) {
        return state.repliedMessage.id.isEmpty
            ? const SizedBox.shrink()
            : MessageReplyBox(
          message: state.repliedMessage!,
          isSentByMe: state.repliedMessageIsSentByMe,
          replying: true,
        );
      },
    );
  }
}