part of 'conversation_widgets.dart';

class SentMessageProgressIndicator extends StatelessWidget {
  const SentMessageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (p, c) => p.sendingMessage != c.sendingMessage,
      builder: (context, state) {
        return !state.sendingMessage
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: LoadingAnimationWidget.waveDots(
                    color: Theme.of(context).colorScheme.primary,
                    size: 40),
                ));
      },
    );
  }
}
