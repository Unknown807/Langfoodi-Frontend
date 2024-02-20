import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/entities/conversation/conversation_entities.dart';
import 'package:recipe_social_media/entities/user/user_entities.dart';
import 'package:recipe_social_media/pages/add_group/models/group_name.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

export 'add_group_bloc.dart';
part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  AddGroupBloc(
    this._authRepo,
    this._conversationRepo) : super(AddGroupState(
      searchTextController: TextEditingController(),
    )) {
      on<GroupNameChanged>(_groupNameChanged);
      on<SearchForUsers>(_searchForUsers);
      on<SelectUser>(_selectUser);
      on<DeselectUser>(_deselectUser);
      on<CreateGroup>(_createGroup);
      on<ResetDialog>(_resetDialog);
    }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;

  void _resetDialog(ResetDialog event, Emitter<AddGroupState> emit) {
    emit(state.copyWith(
      dialogTitle: "",
      dialogMessage: ""
    ));
  }

  void _createGroup(CreateGroup event, Emitter<AddGroupState> emit) async {
    bool groupNameValid = Formz.validate([state.groupName]);
    if (state.selectedUsers.isEmpty || !groupNameValid) {
      return emit(state.copyWith(
        groupNameValid: groupNameValid
      ));
    }

    emit(state.copyWith(pageLoading: true));
    bool formSuccess = false;
    String dialogTitle = "Oops!";
    String dialogMessage = "Could not create group, please check and try again.";

    String currentUserId = (await _authRepo.currentUser).id;
    Group? newGroup = await _conversationRepo.createGroup(
      state.groupName.value,
      state.selectedUsers.map((usr) => usr.id).toList()..add(currentUserId)
    );

    if (newGroup == null) {
      return emit(state.copyWith(
        pageLoading: false,
        formSuccess: formSuccess,
        dialogTitle: dialogTitle,
        dialogMessage: dialogMessage
      ));
    }

    Conversation? newConversation = await _conversationRepo.createConversationByGroup(
      newGroup.id, currentUserId
    );
    if (newConversation != null) {
      dialogTitle = "Success!";
      dialogMessage = "Group created!";
      formSuccess = true;
    } else {
      await _conversationRepo.deleteGroup(newGroup.id);
    }

    emit(state.copyWith(
      pageLoading: false,
      formSuccess: formSuccess,
      dialogTitle: dialogTitle,
      dialogMessage: dialogMessage,
    ));
  }

  void _deselectUser(DeselectUser event, Emitter<AddGroupState> emit) async {
    List<UserAccount> selectedUsers = List.from(state.selectedUsers);
    selectedUsers.removeWhere((usr) => usr.id == event.userId);

    emit(state.copyWith(
      selectedUsers: selectedUsers,
      selectedUsersBoxHeight: selectedUsers.isEmpty ? 0 : 75,
    ));
  }

  void _selectUser(SelectUser event, Emitter<AddGroupState> emit) async {
    if (state.selectedUsers.any((usr) => usr.id == event.user.id)) return;

    List<UserAccount> selectedUsers = List.from(state.selectedUsers);
    selectedUsers.add(event.user);

    emit(state.copyWith(
      selectedUsers: selectedUsers,
      selectedUsersBoxHeight: 75
    ));
  }

  void _searchForUsers(SearchForUsers event, Emitter<AddGroupState> emit) async {
    final searchTerm = state.searchTextController.value.text.toLowerCase();
    if (searchTerm.isEmpty || searchTerm == state.prevSearchTerm) return;

    emit(state.copyWith(searchLoading: true));
    final userId = (await _authRepo.currentUser).id;
    List<UserAccount> users = await _authRepo.searchAndGetConnectedUsers(searchTerm, userId);

    emit(state.copyWith(
      searchedUsers: users,
      prevSearchTerm: searchTerm,
      searchLoading: false
    ));
  }

  void _groupNameChanged(GroupNameChanged event, Emitter<AddGroupState> emit) {
    final name = GroupName.dirty(event.name);

    emit(state.copyWith(
      groupName: name,
      groupNameValid: Formz.validate([name])
    ));
  }
}