import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';

export 'conversation_bloc.dart';
part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(const ConversationState()) {
    on<InitState>(_initState);
    on<ChangeMessagesToDisplay>(_changeMessagesToDisplay);
  }

  void _initState(InitState event, Emitter<ConversationState> emit) {
    final messages = _getMessagesFromConversation();
    // TODO: get senderId from currentUser in auth repo

    emit(state.copyWith(
      conversationName: event.conversationName,
      isGroup: event.isGroup,
      messages: messages,
      senderId: "1"
    ));
  }

  void _changeMessagesToDisplay(ChangeMessagesToDisplay event, Emitter<ConversationState> emit) async {
    // TODO: get messages from API
  }

  List<Message> _getMessagesFromConversation() {
    return [
      Message(id: "1", senderId: "2",
        textContent: "Hey how are you doing?",
        sentDate: DateTime(2024, 01, 21, 9, 0),
      ),
      Message(id: "2", senderId: "1",
        textContent: "good, here's pictures of my morning!",
        sentDate: DateTime(2024, 01, 21, 11, 30),
        imageURLs: ["ag3pi6mfvqnzaknnmqri", "d3uwdc4ekb4z9dkgqc9f"]
      ),
      Message(id: "3", senderId: "2",
        textContent: "here's a pic of me :)",
        sentDate: DateTime(2024, 02, 21, 12, 15),
        imageURLs: ["q8jjeukocprdiblv25tf"]
      ),
      Message(id: "4", senderId: "1",
        textContent: "You seen my recipes, check 'em out!",
        sentDate: DateTime(2024, 10, 25, 12, 20),
        recipeIds: ["6586f5660423a34d151f4424", "658447bb717f5f37d4f32104"]
      ),
      Message(id: "5", senderId: "2",
        textContent: "Nice, its similar to what I made yesterday -",
        sentDate: DateTime(2024, 10, 25, 13, 45),
        recipeIds: ["65885d44cf28ab4f72179f11"]
      ),
      Message(id: "6", senderId: "2",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "7", senderId: "1",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "8", senderId: "2",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "9", senderId: "1",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "10", senderId: "2",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "11", senderId: "1",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "12", senderId: "2",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
      Message(id: "13", senderId: "1",
        repliedToMessageId: "5",
        textContent: "Seeya later!",
        sentDate: DateTime(2024, 10, 25, 14, 55),
      ),
    ];
  }
}