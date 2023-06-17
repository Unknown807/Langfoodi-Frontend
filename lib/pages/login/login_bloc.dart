import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/pages/register/register_page.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navig_repo.dart';

part 'login_form.dart';

class LoginBloc extends FormBloc {
  LoginBloc({required AuthenticationRepository authRepo})
      : _authRepo = authRepo,
        super();

  final AuthenticationRepository _authRepo;

  @override
  Future<void> formSubmitted(FormSubmitted event, Emitter<InputState> emit) async {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    String? errorMessage = await _authRepo.loginWithUserNameOrEmail(
        state.email.value, state.password.value);

    emit(state.copyWith(
        errorMessage: errorMessage,
        formStatus: errorMessage == null
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure));
  }
}
