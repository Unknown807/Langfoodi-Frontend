import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/args/image_view/image_view_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class CloudinaryImageViewPage extends StatelessWidget {
  const CloudinaryImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ImageViewPageArguments;
    final imageUrl = args.imageUrl;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            color: Theme.of(context).colorScheme.tertiary,
            size: 30,
          ),
          onPressed: () => context.read<NavigationRepository>()
              .goTo(context, "/recipe-interaction", routeType: RouteType.backLink),
        ),
      ),
      body: InteractiveViewer(
        maxScale: 3.0,
        minScale: 0.01,
        boundaryMargin: const EdgeInsets.all(double.infinity),
        child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: context.read<ImageBuilder>().displayCloudinaryImage(
                imageUrl: imageUrl,
                transformationType: ImageTransformationType.high,
                errorBuilder: (context, obj1, obj2) {
                  return CustomIconTile(
                    icon: Icons.close,
                    iconSize: 100,
                    iconColor: Theme.of(context).colorScheme.error,
                    tileColor: Theme.of(context).colorScheme.background,
                  );
                },
              ),
            )
        )
      )
    );
  }
}