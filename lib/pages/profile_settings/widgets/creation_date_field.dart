part of 'profile_settings_widgets.dart';

class CreationDateField extends StatelessWidget {
  const CreationDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "Joined On ${state.creationDate}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary
            ),
          ),
        );
      },
    );
  }
}