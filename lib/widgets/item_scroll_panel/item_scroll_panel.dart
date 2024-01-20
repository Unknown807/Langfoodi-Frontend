part of 'package:recipe_social_media/widgets/shared_widgets.dart';

class ItemScrollPanel extends StatelessWidget {
  const ItemScrollPanel(
    {super.key,
    required this.items,
    required this.scrollDirection,
    required this.imageAspectRatio,
    this.onTap,
    this.onTapButton,
    this.buttonIcon,
    this.hasButton = false,
    this.titleFontSize = 18,
    this.imageBorderRadius = 20});

  final bool hasButton;
  final double titleFontSize;
  final double imageBorderRadius;
  final double imageAspectRatio;
  final List<ScrollItem> items;
  final Axis scrollDirection;
  final Function? onTap;
  final Function? onTapButton;
  final Icon? buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        scrollDirection: scrollDirection,
        itemBuilder: (context, index) => buildScrollItem(context, items[index]),
        separatorBuilder: (context, _) => const SizedBox(height: 10),
        itemCount: items.length));
  }

  Widget buildScrollItem(BuildContext context, ScrollItem item) {
    return Container(
      width: 200,
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => onTap?.call(item),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(item.title,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.onBackground
                    ))
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: AspectRatio(
                  aspectRatio: imageAspectRatio,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(imageBorderRadius),
                    child: context.read<ImageBuilder>().decideOnAndDisplayImage(
                      isAsset: true,
                      imageUrl: item.urlImage ?? "assets/images/no_image.png",
                      transformationType: ImageTransformationType.standard,
                      errorBuilder: (context, obj1, obj2) {
                        return CustomIconTile(
                          icon: Icons.error,
                          iconColor: Theme.of(context).colorScheme.error,
                          tileColor: Theme.of(context).colorScheme.error,
                          borderRadius: 20,
                        );
                      },
                    )
                  )),
                )
              ],
            ),
          ),
          if (hasButton)
            Positioned(
              top: 35,
              right: 5,
              child: IconButton(
                iconSize: 30,
                icon: buttonIcon!,
                onPressed: () => onTapButton?.call(item),
              ),
            ),
        ]
      )
    );
  }
}
