import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'add_connection_bloc.dart';
part 'add_connection_event.dart';
part 'add_connection_state.dart';

class AddConnectionBloc extends Bloc<AddConnectionEvent, AddConnectionState> {
  AddConnectionBloc(
    this._authRepo,
    this._conversationRepo,
    this._networkManager) : super(AddConnectionState(
      searchTextController: TextEditingController()
    )) {
      on<SearchForUsers>(_searchForUsers);
      on<CreateConversation>(_createConversation);
      on<ResetDialog>(_resetDialog);
    }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;
  final NetworkManager _networkManager;

  void _resetDialog(ResetDialog event, Emitter<AddConnectionState> emit) {
    emit(state.copyWith(
      dialogTitle: "",
      dialogMessage: "",
    ));
  }

  void _createConversation(CreateConversation event, Emitter<AddConnectionState> emit) async {
    emit(state.copyWith(pageLoading: true));
    bool hasNetwork = await _networkManager.isNetworkConnected();
    if (!hasNetwork) {
      return emit(state.copyWith(
        pageLoading: false,
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection."
      ));
    }

    bool formSuccess = false;
    String dialogTitle = "Oops!";
    String dialogMessage = "Could not start the conversation, please check and try again.";

    String currentUserId = (await _authRepo.currentUser).id;
    Connection? newConnection = await _conversationRepo.createConnection(currentUserId, event.userId);
    if (newConnection == null) {
      return emit(state.copyWith(
        pageLoading: false,
        formSuccess: formSuccess,
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
      formSuccess = true;
    }

    emit(state.copyWith(
      pageLoading: false,
      formSuccess: formSuccess,
      dialogTitle: dialogTitle,
      dialogMessage: dialogMessage
    ));
  }

  void _searchForUsers(SearchForUsers event, Emitter<AddConnectionState> emit) async {
    final searchTerm = state.searchTextController.value.text.toLowerCase();
    if (searchTerm.isEmpty || searchTerm == state.prevSearchTerm) return;

    emit(state.copyWith(searchLoading: true));
    bool hasNetwork = await _networkManager.isNetworkConnected();
    if (!hasNetwork) {
      return emit(state.copyWith(
        searchLoading: false,
        dialogTitle: "Oops!",
        dialogMessage: "Network issue encountered, please check your internet connection."
      ));
    }

    final userId = (await _authRepo.currentUser).id;
    List<UserAccount> users = await _authRepo.searchAndGetUnconnectedUsers(searchTerm, userId);

    emit(state.copyWith(
      users: users,
      prevSearchTerm: searchTerm,
      searchLoading: false
    ));
  }
}