import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_social_media/forms/form_bloc.dart';
import '../forms/input_event.dart';
import '../forms/input_state.dart';

class RegisterBloc extends FormBloc {
  @override
  Future<void> formSubmitted(FormSubmitted event, Emitter<InputState> emit) async {
    print("Register form submitted");
    emit(
      state.copyWith(
        errorMessage: "Specific Failure Message Here",
        status: FormzSubmissionStatus.failure,
      ),
    );
  }
}