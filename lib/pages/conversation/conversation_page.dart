import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/conversation/bloc/conversation_bloc.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation/conversation_page_arguments.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var convoDetails = ModalRoute.of(context)!.settings.arguments as ConversationPageArguments;

    return BlocProvider(
      create: (_) => ConversationBloc()
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(flex: 8, child: MessageList()),
            Expanded(
              flex: 1,
              child: Row(
              children: [
                const Expanded(flex: 6, child: MessageInput()),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    padding: const EdgeInsets.only(left: 5),
                    splashRadius: 25,
                    color: Theme.of(context).colorScheme.tertiary,
                    icon: const Icon(Icons.fastfood),
                    onPressed: () {},
                  )
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 5),
                    splashRadius: 25,
                    color: Theme.of(context).colorScheme.tertiary,
                    icon: const Icon(Icons.image_rounded),
                    onPressed: () {},
                  )
                )
              ],
            ))
          ]
        )
      )
    );
  }
}