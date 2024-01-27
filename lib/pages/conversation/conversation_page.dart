import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation/bloc/conversation_bloc.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation/conversation_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var convoDetails = ModalRoute.of(context)!.settings.arguments as ConversationPageArguments;

    return BlocProvider(
      create: (_) => ConversationBloc(
        context.read<NavigationRepository>(),
        context.read<AuthenticationRepository>(),
        context.read<RecipeRepository>()
      )
      ..add(InitState(
        convoDetails.conversationName,
        convoDetails.conversationStatus,
        convoDetails.isGroup
      )),
      child: Scaffold(
        appBar: CustomSearchAppBar(
          title: Row(
            children: [
              CustomCircleAvatar(
                avatarIcon: convoDetails.isGroup ? Icons.group : Icons.person,
                conversationStatus: convoDetails.conversationStatus,
                avatarIconSize: 25,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(convoDetails.conversationName,
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
          onSearchFunc: (term) {print(term);},
        ),
        body: Column (
          children: [
            const Expanded(flex: 8, child: MessageList()),
            Row(
              children: [
                const Expanded(flex: 1, child: AttachRecipeButton()),
                const Expanded(flex: 1, child: AttachImageButton()),
                const Expanded(flex: 5, child: MessageInput()),
                IconButton(
                  splashRadius: 20,
                  color: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                )
              ],
            )
          ]
        )
      )
    );
  }
}