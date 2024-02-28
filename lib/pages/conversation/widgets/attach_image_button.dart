part of 'conversation_widgets.dart';

class AttachImageButton extends StatelessWidget {
  const AttachImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      buildWhen: (p, c) =>
        p.allowImages != c.allowImages
        || p.pageLoading != c.pageLoading
        || p.sendingMessage != c.sendingMessage,
      builder: (context, state) {
        return IconButton(
          padding: EdgeInsets.zero,
          iconSize: 22,
          splashRadius: 20,
          disabledColor: Theme.of(context).hintColor,
          color: Theme.of(context).colorScheme.tertiary,
          icon: const Icon(Icons.image_rounded),
          onPressed: !state.allowImages || state.pageLoading || state.sendingMessage || state.isBlocked ? null : () async {
            final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
            if (selectedImages.isNotEmpty && context.mounted) {
              context.read<ConversationBloc>().add(AttachImages(selectedImages));
            }
          },
        );
      },
    );
  }
}