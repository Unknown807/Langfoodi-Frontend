part of 'conversation_widgets.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return FormInput(
          textController: state.messageTextController,
          innerPadding: const EdgeInsets.symmetric(horizontal: 10),
          outerPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          hintText: "Message...",
          boxDecorationType: FormInputBoxDecorationType.roundedTextArea,
          fontSize: 14,
          maxLines: 1,
          eventFunc: (_) {}
        );
      }
    );
  }
}