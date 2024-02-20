import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/add_group/bloc/add_group_bloc.dart';
import 'package:recipe_social_media/pages/add_group/widgets/add_group_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGroupBloc(
        context.read<AuthenticationRepository>(),
        context.read<ConversationRepository>(),
        context.read<NetworkManager>()
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("New Group"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButton: const AddGroupButton(),
        body: BlocConsumer<AddGroupBloc, AddGroupState>(
          listener: (context, state) {
            if (state.dialogTitle.isNotEmpty) {
              showDialog(
                context: context,
                builder: (_) => BlocProvider<AddGroupBloc>.value(
                  value: BlocProvider.of<AddGroupBloc>(context),
                  child: CustomAlertDialog(
                    title: Text(state.dialogTitle),
                    content: Text(state.dialogMessage),
                    leftButtonText: null,
                    rightButtonCallback: state.formSuccess
                      ? () => context
                        .read<NavigationRepository>()
                        .goTo(context, "/conversation-list", routeType: RouteType.backLink)
                      : () => context
                        .read<AddGroupBloc>()
                        .add(const ResetDialog())
                  ),
                )
              );
            }
          },
          builder: (context, state) {
            return state.pageLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    const GroupNameInput(),
                    Divider(
                      color: Theme.of(context).hintColor.withAlpha(40),
                      thickness: 3,
                      height: 5,
                    ),
                    const SelectedUsersCounter(),
                    const SelectedUserList(),
                    const UserSearchInput(),
                    const Expanded(child: SearchedUserList())
                  ],
                );
          },
        )
      ),
    );
  }
}