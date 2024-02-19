import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/pages/add_group/models/group_name.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

export 'add_group_bloc.dart';
part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  AddGroupBloc(
    this._authRepo,
    this._conversationRepo) : super(const AddGroupState(
      //TODO: controller here
    )) {
      on<GroupNameChanged>(_groupNameChanged);
    }

  final AuthenticationRepository _authRepo;
  final ConversationRepository _conversationRepo;

  void _groupNameChanged(GroupNameChanged event, Emitter<AddGroupState> emit) {
    final name = GroupName.dirty(event.name);

    emit(state.copyWith(
      groupName: name,
      groupNameValid: Formz.validate([name])
    ));
  }
}