import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/pages/conversation/bloc/conversation_bloc.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/message/message_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    //var convoDetails = ModalRoute.of(context)!.settings.arguments as ConversationPageArguments;

    Conversation convo = const Conversation(
      "65c5317147169650f0d44687",
      "connectionOrGroupId",
      "test2",
      null,
      false,
      null,
      0
    );

    return BlocProvider(
      create: (_) => ConversationBloc(
        context.read<NavigationRepository>(),
        context.read<AuthenticationRepository>(),
        context.read<RecipeRepository>(),
        context.read<MessageRepository>(),
        context.read<NetworkManager>()
      )..add(InitState(convo)),
      child: Scaffold(
        appBar: CustomSearchAppBar(
          title: Row(
            children: [
              CustomCircleAvatar(
                avatarIcon: convo.isGroup ? Icons.group : Icons.person,
                //TODO: status will be refactored eventually
                //conversationStatus: convo.conversationStatus,
                avatarIconSize: 25,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(convo.name,
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
        body: const Column (
          children: [
            Expanded(flex: 8, child: MessageList()),
            Row(
              children: [
                Expanded(flex: 1, child: AttachRecipeButton()),
                Expanded(flex: 1, child: AttachImageButton()),
                Expanded(flex: 5, child: MessageInput()),
                MessageSendButton()
              ],
            )
          ]
        )
      )
    );
  }
}