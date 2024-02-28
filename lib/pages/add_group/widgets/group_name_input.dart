part of 'add_group_widgets.dart';

class GroupNameInput extends StatelessWidget {
  const GroupNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      buildWhen: (p, c) =>
        p.groupName != c.groupName
        || p.groupNameValid != c.groupNameValid,
      builder: (context, state) {
        return FormInput(
          labelText: "Group Name",
          outerPadding: const EdgeInsets.all(20),
          innerPadding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          boxDecorationType: FormInputBoxDecorationType.textArea,
          errorText: state.groupNameValid ? null : "Only use alphanumeric characters or !, _, ), (",
          fontSize: 18,
          eventFunc: (name) => context
            .read<AddGroupBloc>()
            .add(GroupNameChanged(name)),
        );
      }
    );
  }
}