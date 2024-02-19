import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

export 'add_connection_bloc.dart';
part 'add_connection_event.dart';
part 'add_connection_state.dart';

class AddConnectionBloc extends Bloc<AddConnectionEvent, AddConnectionState> {
  AddConnectionBloc(
    this._authRepo,
    this._conversationRepo) : super(AddConnectionState(
      searchTextController: TextEditingController()
    )) {
      on<SearchForUsers>(_searchForUsers);
      on<CreateConversation>(_createConversation);
    }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;

  void _createConversation(CreateConversation event, Emitter<AddConnectionState> emit) async {
    emit(state.copyWith(pageLoading: true));
    String dialogTitle = "Oops!";
    String dialogMessage = "Could not start the conversation, please check and try again.";

    String currentUserId = (await _authRepo.currentUser).id;
    Connection? newConnection = await _conversationRepo.createConnection(currentUserId, event.userId);
    if (newConnection == null) {
      return emit(state.copyWith(
        pageLoading: false,
        dialogTitle: dialogTitle,
        dialogMessage: dialogMessage
      ));
    }

    Conversation? newConversation = await _conversationRepo.createConversationByConnection(
      newConnection.connectionId, event.userId
    );
    if (newConversation != null) {
      dialogTitle = "Success!";
      dialogMessage = "Conversation created!";
    }

    emit(state.copyWith(
      pageLoading: false,
      dialogTitle: dialogTitle,
      dialogMessage: dialogMessage
    ));
  }

  void _searchForUsers(SearchForUsers event, Emitter<AddConnectionState> emit) async {
    final searchTerm = state.searchTextController.value.text.toLowerCase();
    if (searchTerm.isEmpty || searchTerm == state.prevSearchTerm) return;

    emit(state.copyWith(searchLoading: true));
    List<UserAccount> users = await _authRepo.searchAndGetUsers(searchTerm);

    emit(state.copyWith(
      users: users,
      prevSearchTerm: searchTerm,
      searchLoading: false
    ));
  }
}