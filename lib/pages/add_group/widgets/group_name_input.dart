part of 'add_group_widgets.dart';

class GroupNameInput extends StatelessWidget {
  const GroupNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddGroupBloc, AddGroupState>(
      builder: (context, state) {
        return FormInput(
          labelText: "Group Name",
          outerPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
          innerPadding: const EdgeInsets.symmetric(horizontal: 10),
          boxDecorationType: FormInputBoxDecorationType.textArea,
          fontSize: 18,
          eventFunc: (_) {},
          onSubmittedEventFunc: (_) {},
        );
      }
    );
  }
}