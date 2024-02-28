import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_social_media/pages/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:recipe_social_media/repositories/navigation/navigation_repo.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:recipe_social_media/widgets/shared_widgets.dart';
import 'widgets/conversation_list_widgets.dart';

class ConversationListPage extends StatelessWidget implements PageLander  {
  const ConversationListPage({super.key});

  @override
  void onLanding(BuildContext context) {
    BlocProvider.of<ConversationListBloc>(context)
     .add(const ChangeConversationsToDisplay());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConversationListBloc, ConversationListState>(
      listener: (context, state) {
        if (state.dialogTitle.isNotEmpty) {
          showDialog(
            context: context,
            builder: (_) => BlocProvider<ConversationListBloc>.value(
              value: BlocProvider.of<ConversationListBloc>(context),
              child: CustomAlertDialog(
                title: Text(state.dialogTitle),
                content: Text(state.dialogMessage),
                leftButtonText: null,
                rightButtonCallback: () => context
                  .read<ConversationListBloc>()
                  .add(const ResetPopupDialog())
              ),
            )
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomSearchAppBar(
            title: const Text("Conversations"),
            hintText: "Search Your Conversations",
            suggestions: state.searchSuggestions,
            onSearchFunc: (term) => context
              .read<ConversationListBloc>()
              .add(SearchConversations(term))
          ),
          floatingActionButton: ExpandableFab(
            key: const Key("conversationListPage"),
            distance: 100,
            openIcon: const Icon(Icons.add, size: 40),
            closeIcon: const Icon(Icons.close, size: 30),
            children: [
              ActionButton(
                icon: Icon(
                  Icons.group_add_rounded,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 30),
                onPressed: () => context
                  .read<NavigationRepository>()
                  .goTo(context, "/add-group")
              ),
              ActionButton(
                icon: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 30),
                onPressed: () => context
                  .read<NavigationRepository>()
                  .goTo(context, "/add-connection")
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              state.conversations.isNotEmpty || state.pageLoading
                ? const ConversationList()
                : Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                        child: Text("You have no conversations yet! (Or they're loading)",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground.withAlpha(180),
                            fontSize: 20
                          )
                        )
                      ),
                      LoadingAnimationWidget.newtonCradle(
                        color: Theme.of(context).colorScheme.primary,
                        size: 150
                      )
                    ],
              )
            ]
          )
        );
      }
    );
  }
}