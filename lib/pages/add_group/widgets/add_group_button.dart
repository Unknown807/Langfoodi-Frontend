part of 'add_group_widgets.dart';

class AddGroupButton extends StatelessWidget {
  const AddGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFloatingButton(
      key: const Key("addGroupPage"),
      icon: Icons.check_rounded,
      eventFunc: () => showDialog(
        context: context,
        builder: (_) => BlocProvider<AddGroupBloc>.value(
          value: BlocProvider.of<AddGroupBloc>(context),
          child: CustomAlertDialog(
            title: const Text("Create Group"),
            content: const Text("Ready to create your group?"),
            rightButtonText: "Yes",
            rightButtonCallback: () => context
              .read<AddGroupBloc>()
              .add(const CreateGroup()),
          ),
        )
      )
    );
  }
}