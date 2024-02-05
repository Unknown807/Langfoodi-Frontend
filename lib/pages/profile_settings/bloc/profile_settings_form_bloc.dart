import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';

export 'profile_settings_form_bloc.dart';
part 'profile_settings_form_event.dart';

class ProfileSettingsFormBloc extends FormBloc {
  ProfileSettingsFormBloc(this._authRepo): super() {
    on<UpdateUsername>(_updateUsername);
    on<UpdateEmail>(_updateEmail);
    on<UpdatePassword>(_updatePassword);
  }

  final AuthenticationRepository _authRepo;

  void _updatePassword(UpdatePassword event, Emitter<InputState> emit) {
    print("updating password");
    print(state.password.value);
    print(state.confirmedPassword.value);
  }

  void _updateEmail(UpdateEmail event, Emitter<InputState> emit) {
    print("updating new email");
    print(state.email.value);
  }

  void _updateUsername(UpdateUsername event, Emitter<InputState> emit) {
    if (!state.userNameValid) return;

    
  }
}