import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/add_connection/bloc/add_connection_bloc.dart';
import 'package:recipe_social_media/pages/add_connection/widgets/add_connection_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';

class AddConnectionPage extends StatelessWidget {
  const AddConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddConnectionBloc(
        context.read<AuthenticationRepository>(),
        context.read<ConversationRepository>(),
        context.read<NetworkManager>()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New Friend"),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: BlocConsumer<AddConnectionBloc, AddConnectionState>(
          listener: (context, state) {
            if (state.dialogTitle.isNotEmpty) {
              showDialog(
                context: context,
                builder: (_) => BlocProvider<AddConnectionBloc>.value(
                  value: BlocProvider.of<AddConnectionBloc>(context),
                  child: CustomAlertDialog(
                    title: Text(state.dialogTitle),
                    content: Text(state.dialogMessage),
                    leftButtonText: null,
                    rightButtonCallback: state.formSuccess
                      ? () => context
                        .read<NavigationRepository>()
                        .goTo(context, "/conversation-list", routeType: RouteType.backLink)
                      : () => context
                        .read<AddConnectionBloc>()
                        .add(const ResetDialog())
                  ),
                )
              );
            }
          },
          buildWhen: (p, c) => p.pageLoading != c.pageLoading,
          builder: (context, state) {
            return state.pageLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    const UserSearchInput(),
                    Divider(
                      color: Theme.of(context).hintColor.withAlpha(40),
                      thickness: 3,
                      height: 5,
                    ),
                    const Expanded(child: SearchedUserList())
                  ],
                );
          },
        )
      ),
    );
  }
}