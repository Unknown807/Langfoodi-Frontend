import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_social_media/pages/add_group/bloc/add_group_bloc.dart';
import 'package:recipe_social_media/pages/add_group/widgets/add_group_widgets.dart';
import 'package:recipe_social_media/repositories/authentication/auth_repo.dart';
import 'package:recipe_social_media/repositories/conversation/conversation_repo.dart';

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGroupBloc(
        context.read<AuthenticationRepository>(),
        context.read<ConversationRepository>()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New Group"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: BlocConsumer<AddGroupBloc, AddGroupState>(
          listener: (context, state) {},
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
                    const UserSearchInput()
                  ],
                );
          },
        )
      ),
    );
  }
}