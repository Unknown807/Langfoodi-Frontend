import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/pages/conversation_list/models/conversation_card_content.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation/conversation_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({super.key, required this.conversationCardContent});

  static const double conversationIconSize = 30;
  static const double statusIconSize = 20;
  static const double pinIconSize = 25;

  final ConversationCardContent conversationCardContent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => context
              .read<NavigationRepository>()
              .goTo(context, "/conversation",
                arguments: ConversationPageArguments(
                  conversationStatus: conversationCardContent.details.conversationStatus,
                  conversationName: conversationCardContent.details.conversationName,
                  isGroup: conversationCardContent.details.isGroup)),
            child: Center(
              child: Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CustomCircleAvatar(
                        avatarIcon: conversationCardContent.details.isGroup ? Icons.group : Icons.person,
                        conversationStatus: conversationCardContent.details.conversationStatus,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(flex: 1, child: Text(conversationCardContent.details.conversationName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                          Text(conversationCardContent.lastMessageSentDate != null
                            ? DateFormat("dd/MM/yyyy").format(conversationCardContent.lastMessageSentDate!) : "",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 12)
                          )
                        ]
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(flex: 1, child: Text(conversationCardContent.lastMessage.isNotEmpty
                            ? "${conversationCardContent.lastMessageSender}: ${conversationCardContent.lastMessage}" : "",
                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                          )),
                          if (conversationCardContent.details.isPinned)
                            Transform.rotate(angle: pi / 4, child: const Icon(Icons.push_pin, size: pinIconSize))
                        ]
                      )
                  ),
                ],
              ),
            )
          )
        );
      }
    );
  }

  Widget getStatusIcon(ConversationStatus conversationStatus, ThemeData themeData) {
    switch (conversationStatus) {
      case ConversationStatus.blocked:
        return Icon(
          Icons.block,
          color: themeData.colorScheme.inversePrimary,
          size: statusIconSize,
        );
      case ConversationStatus.pending:
        return Icon(
          Icons.pending,
          color: themeData.colorScheme.tertiary.withGreen(180),
          size: statusIconSize,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}