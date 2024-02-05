import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

export 'profile_settings_form_bloc.dart';
part 'profile_settings_form_event.dart';

class ProfileSettingsFormBloc extends FormBloc {
  ProfileSettingsFormBloc(this._authRepo, this._networkManager): super() {
    on<UpdateUsername>(_updateUsername);
    on<UpdateEmail>(_updateEmail);
    on<UpdatePassword>(_updatePassword);
    on<UpdateProfileImage>(_updateProfileImage);
  }

  final AuthenticationRepository _authRepo;
  final NetworkManager _networkManager;

  void _updateProfileImage(UpdateProfileImage event, Emitter<InputState> emit) {
    print(event.imagePath);
  }

  void _updatePassword(UpdatePassword event, Emitter<InputState> emit) {
    print("updating password");
    print(state.password.value);
    print(state.confirmedPassword.value);
  }

  void _updateEmail(UpdateEmail event, Emitter<InputState> emit) {
    print("updating new email");
    print(state.email.value);
  }

  void _updateUsername(UpdateUsername event, Emitter<InputState> emit) async {
    if (!state.userNameValid) return;

    String errorMessage = "";
    bool hasNetwork = await _networkManager.isNetworkConnected();

    if (!hasNetwork) {
      errorMessage = "Network Issue Encountered";
    } else {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      final userId = (await _authRepo.currentUser).id;
      errorMessage = await _authRepo.updateUser(
        id: userId,
        username: state.userName.value
      );
    }

    emit(state.copyWith(
      errorMessage: errorMessage,
      formStatus: errorMessage.isEmpty
        ? FormzSubmissionStatus.success
        : FormzSubmissionStatus.failure,
    ));
  }
}