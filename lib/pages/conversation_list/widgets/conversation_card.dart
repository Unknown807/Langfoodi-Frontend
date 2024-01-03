import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recipe_social_media/entities/messaging/conversation_card_content.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({super.key, required this.conversationCardContent});

  static const double conversationIconSize = 30;
  static const double statusIconSize = 20;
  static const double pinIconSize = 25;

  final ConversationCardContent conversationCardContent;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
          child: BlocBuilder<ConversationListBloc, ConversationListState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => context
                  .read<ConversationListBloc>()
                  .add(NavigateToConversation(conversationCardContent.details, context)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color.fromRGBO(106, 113, 117, 1),
                            child: Icon(
                              conversationCardContent.details.isGroup ? Icons.group : Icons.person,
                              color: const Color.fromRGBO(207, 212, 214, 1),
                              size: conversationIconSize,
                            )
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                        width: 8,
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                                getStatusIcon(conversationCardContent.details.conversationStatus)
                              ]
                            ),
                          )
                        ],
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(conversationCardContent.details.conversationName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            conversationCardContent.lastMessageSentDate != null
                              ? DateFormat("dd/MM/yyyy").format(conversationCardContent.lastMessageSentDate!)
                              : "",
                            style: const TextStyle(fontSize: 12))
                        ]
                      ),
                      subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                conversationCardContent.lastMessage.isNotEmpty
                                    ? "${conversationCardContent.lastMessageSender}: ${conversationCardContent.lastMessage}"
                                    : "",
                                style: const TextStyle(fontSize: 16)
                            ),
                            conversationCardContent.details.isPinned
                                ? Transform.rotate(angle: pi / 4, child: const Icon(Icons.push_pin, size: pinIconSize))
                                : const SizedBox (width: pinIconSize, height: pinIconSize)
                          ]
                      )
                  ),
              ],
            ),
          );
        })
      )
    );
  }

  Widget getStatusIcon(ConversationStatus conversationStatus) {
    switch (conversationStatus) {
      case ConversationStatus.blocked:
        return const Icon(
          Icons.block,
          color: Colors.red,
          size: statusIconSize,
        );
      case ConversationStatus.pending:
        return const Icon(
          Icons.pending,
          color: Colors.lightBlueAccent,
          size: statusIconSize,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}