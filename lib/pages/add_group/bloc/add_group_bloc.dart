import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
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
    }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;

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