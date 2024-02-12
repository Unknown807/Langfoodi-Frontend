part of 'conversation_widgets.dart';

class ImageAttachmentBox extends StatelessWidget {
  const ImageAttachmentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (context, state) {
        return state.attachedImagePaths.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 3),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 60,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.attachedImagePaths.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 8);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final img = state.attachedImagePaths[index];
                      return Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: context.read<ImageBuilder>().displayLocalImage(
                                imagePath: img,
                                errorBuilder: (context, obj1, obj2) {
                                  return CustomIconTile(
                                    padding: null,
                                    icon: Icons.error,
                                    backgroundColor: Theme.of(context).colorScheme.background,
                                    iconColor: Theme.of(context).colorScheme.error,
                                    tileColor: Theme.of(context).colorScheme.error,
                                  );
                                },
                              ),
                            )
                          ),
                          Positioned(
                            bottom: 25,
                            right: 25,
                            child: IconButton(
                              onPressed: () {},
                              splashRadius: 5,
                              icon: Icon(
                                Icons.cancel_rounded,
                                color: Theme.of(context).colorScheme.inversePrimary,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
            )
        );
      },
    );
  }
}