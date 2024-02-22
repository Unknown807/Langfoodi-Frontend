part of 'conversation_widgets.dart';

class MessageSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessageSearchAppBar({
    super.key,
    required this.isGroup,
    required this.conversationName,
    required this.thumbnailId
  });

  final bool isGroup;
  final String conversationName;
  final String? thumbnailId;

  @override
  Widget build(BuildContext context) {
    return CustomSearchAppBar(
      title: Row(
        children: [
          thumbnailId != null
            ? SizedBox(
                height: 40,
                width: 37,
                child: ClipOval(
                  child: context.read<ImageBuilder>().displayCloudinaryImage(
                    imageUrl: thumbnailId!,
                    transformationType: ImageTransformationType.tiny,
                    errorBuilder: (err, ob1, ob2) {
                      return CustomIconTile(
                        padding: EdgeInsets.zero,
                        icon: Icons.error,
                        borderStrokeWidth: 4,
                        iconSize: 20,
                        borderRadius: 20,
                        iconColor: Theme.of(context).colorScheme.error,
                        tileColor: Theme.of(context).colorScheme.error,
                      );
                    }
                  ),
                ),
              )
          : CustomCircleAvatar(
              avatarIcon: isGroup ? Icons.group : Icons.person,
              avatarIconSize: 25,
            ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(conversationName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
            )
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {print("more options pressed");},
        )
      ],
      onSearchFunc: (term) => context
        .read<ConversationBloc>()
        .add(SearchMessages(term))
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}