part of 'conversation_list_bloc.dart';

@immutable
sealed class ConversationListEvent extends Equatable {
  const ConversationListEvent();

  @override
  List<Object> get props => [];
}

final class ChangeConversationsToDisplay extends ConversationListEvent {
  const ChangeConversationsToDisplay();
}

final class ChangeSelectedSortingOption extends ConversationListEvent {
  const ChangeSelectedSortingOption(this.selectedSortingOption);

  final SortingOption selectedSortingOption;

  @override
  List<Object> get props => [selectedSortingOption];
}

final class InitState extends ConversationListEvent {
  const InitState();
}
