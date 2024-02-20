part of 'add_group_widgets.dart';

class AddGroupButton extends StatelessWidget {
  const AddGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFloatingButton(
      key: const Key("addGroupPage"),
      icon: Icons.check_rounded,
      eventFunc: () => context
        .read<AddGroupBloc>()
        .add(const CreateGroup())
    );
  }
}