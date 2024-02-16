import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
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
        context.read<NetworkManager>()
      )..add(InitState(args.conversation)),
      child: Scaffold(
        appBar: MessageSearchAppBar(
          isGroup: args.conversation.isGroup,
          conversationName: args.conversation.name,
        ),
        body: Column (
          children: [
            const Expanded(flex: 8, child: MessageList()),
            BlocBuilder<ConversationBloc, ConversationState>(
              buildWhen: (p, c) =>
                p.repliedMessage.id != c.repliedMessage.id
                || p.repliedMessageIsSentByMe != c.repliedMessageIsSentByMe,
              builder: (context, state) {
                return state.repliedMessage.id.isEmpty
                  ? const SizedBox.shrink()
                  : MessageReplyBox(
                      message: state.repliedMessage!,
                      isSentByMe: state.repliedMessageIsSentByMe,
                      replying: true,
                    );
              },
            ),
            const ImageAttachmentBox(),
            const RecipeAttachmentBox(),
            const Row(
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