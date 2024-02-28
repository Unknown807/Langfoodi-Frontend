import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/pages/conversation/bloc/conversation_bloc.dart';
import 'package:recipe_social_media/pages/conversation/widgets/conversation_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/repositories/image/image_repo.dart';
import 'package:recipe_social_media/repositories/message/message_repo.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation/conversation_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ConversationPageArguments;

    return BlocProvider(
      create: (context) => ConversationBloc(
        context.read<NavigationRepository>(),
        context.read<AuthenticationRepository>(),
        context.read<RecipeRepository>(),
        context.read<MessageRepository>(),
        context.read<ImageRepository>(),
        context.read<ConversationRepository>(),
        context.read<NetworkManager>(),
        context.read<MessagingHub>(),
      )..add(InitState(args.conversation, args.isBlocked)),
      child: Scaffold(
        appBar: MessageSearchAppBar(
          isGroup: args.conversation.isGroup,
          isBlocked: args.isBlocked,
          conversationName: args.conversation.name,
          thumbnailId: args.conversation.thumbnailId,
        ),
        body: Container(
          key: const Key("conversationPageBgImg"),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: context.read<ImageBuilder>().getAssetImage(
                "assets/images/convo_${Theme.of(context).brightness == Brightness.light ? "light": "dark"}_bg.png"
              )
            )
          ),
          child: const Column(
            children: [
              Expanded(flex: 8, child: MessageList()),
              ActiveReplyBox(),
              ImageAttachmentBox(),
              RecipeAttachmentBox(),
              Row(
                children: [
                  Expanded(flex: 1, child: AttachRecipeButton()),
                  Expanded(flex: 1, child: AttachImageButton()),
                  Expanded(flex: 5, child: MessageInput()),
                  MessageSendButton()
                ],
              )
            ]
          ),
        )
      )
    );
  }
}