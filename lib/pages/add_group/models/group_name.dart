import 'package:formz/formz.dart';

enum AddGroupFormValidationError {
  groupNameInvalid
}

class GroupName extends FormzInput<String, AddGroupFormValidationError> {
  const GroupName.pure() : super.pure("");
  const GroupName.dirty([super.value = ""]) : super.dirty();

  static final RegExp _groupNameExp = RegExp(r"");

  @override
  AddGroupFormValidationError? validator(String value) {
    return _groupNameExp.hasMatch(value)
      ? null
      : AddGroupFormValidationError.groupNameInvalid;
  }
}