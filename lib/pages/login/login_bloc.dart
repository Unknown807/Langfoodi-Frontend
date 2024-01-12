import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/forms/widgets/form_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

export 'login_bloc.dart';
part 'login_form.dart';

class LoginBloc extends FormBloc {
  LoginBloc({required AuthenticationRepository authRepo, required NetworkManager networkManager})
      : _authRepo = authRepo,
        _networkManager = networkManager,
        super();

  final AuthenticationRepository _authRepo;
  final NetworkManager _networkManager;

  @override
  Future<void> formSubmitted(FormSubmitted event, Emitter<InputState> emit) async {
    String errorMessage = "";
    bool hasNetwork = await _networkManager.isNetworkConnected();

    if (!hasNetwork) {
      errorMessage = "Network Issue Encountered!";
    } else if (state.email.value.isEmpty || state.password.value.isEmpty) {
      errorMessage = "Fields can't be empty";
    } else {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      errorMessage = await _authRepo.loginWithHandlerOrEmail(
        state.email.value, state.password.value);
    }

    emit(state.copyWith(
      errorMessage: errorMessage,
      formStatus: errorMessage.isEmpty
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure));
  }
}
