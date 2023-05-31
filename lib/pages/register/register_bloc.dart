import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../forms/bloc/base_form.dart';
import '../../forms/widgets/form_widgets.dart';

part 'register_form.dart';

class RegisterBloc extends FormBloc {
  @override
  Future<void> formSubmitted(FormSubmitted event, Emitter<InputState> emit) async {
    print("Register form submitted");
    emit(
      state.copyWith(
        errorMessage: "Specific Failure Message Here",
        formStatus: FormzSubmissionStatus.failure,
      ),
    );
  }
}