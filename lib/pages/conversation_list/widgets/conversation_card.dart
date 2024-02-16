import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/args/conversation/conversation_page_arguments.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.conversation
  });

  static const double conversationIconSize = 30;
  static const double statusIconSize = 20;
  static const double pinIconSize = 15;

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationListBloc, ConversationListState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context
            .read<NavigationRepository>()
            .goTo(context, "/conversation",
            arguments: ConversationPageArguments(conversation: conversation)),
          child: Center(
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CustomCircleAvatar(
                      avatarIcon: conversation.isGroup ? Icons.group : Icons.person,
                      // TODO: status will be added later
                      //conversationStatus: conversationCardContent.details.conversationStatus,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            conversation.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ),
                        Text(
                          conversation.lastMessage?.sentDate != null
                            ? DateFormat("dd/MM/yyyy").format(conversation.lastMessage!.sentDate!)
                            : "",
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
                        Expanded(
                          flex: 1,
                          child: Text(
                            conversation.lastMessage != null && conversation.lastMessage!.senderName.isNotEmpty
                              ? "${conversation.lastMessage!.senderName}: ${conversation.lastMessage!.textContent ?? "..."}"
                              : "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: 16
                            ),
                        )),

                        if (conversation.messagesUnseen > 0)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                            child: Chip(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                side: BorderSide.none,
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              label: Text("${conversation.messagesUnseen}"),
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 12
                              ),
                            ),
                          ),

                        if (state.pinnedIds.contains(conversation.id))
                          Transform.rotate(angle: pi / 4, child: const Icon(Icons.push_pin, size: pinIconSize))
                      ]
                    )
                ),
              ],
            ),
          )
        )
      );}
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