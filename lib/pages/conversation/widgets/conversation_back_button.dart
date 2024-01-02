import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';

class ConversationBackButton extends StatelessWidget {
  const ConversationBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_circle_left_outlined,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () => context.read<NavigationRepository>()
          .goTo(context, "conversation-list", routeType: RouteType.backLink),
    );
  }
}