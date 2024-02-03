import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/forms/bloc/base_form.dart';

export 'profile_settings_form_bloc.dart';
part 'profile_settings_form_event.dart';

class ProfileSettingsFormBloc extends FormBloc {
  ProfileSettingsFormBloc(): super() {
    on<UpdateUsername>(_updateUsername);
    on<UpdateEmail>(_updateEmail);
  }

  void _updateEmail(UpdateEmail event, Emitter<InputState> emit) {
    print("updating new email");
    print(state.email.value);
  }

  void _updateUsername(UpdateUsername event, Emitter<InputState> emit) {
    print("updating new username");
    print(state.userName.value);
  }
}