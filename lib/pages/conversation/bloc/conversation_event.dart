part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

final class InitState extends ConversationEvent {
  const InitState(this.conversationName, this.conversationStatus, this.isGroup);

  final String conversationName;
  final ConversationStatus conversationStatus;
  final bool isGroup;

  @override
  List<Object> get props => [conversationName, conversationStatus, isGroup];
}

final class GoToInteractionPageAndExpectResult extends ConversationEvent {
  const GoToInteractionPageAndExpectResult(this.context, this.arguments);

  final BuildContext context;
  final RecipeInteractionPageArguments arguments;

  @override
  List<Object> get props => [context, arguments];
}

final class AttachImages extends ConversationEvent {
  const AttachImages(this.imageFiles);

  final List<XFile> imageFiles;

  @override
  List<Object> get props => [imageFiles];
}

final class SetCheckboxValue extends ConversationEvent {
  const SetCheckboxValue(this.index, this.value);

  final int index;
  final bool value;

  @override
  List<Object> get props => [index, value];
}

final class ScrollToMessage extends ConversationEvent {
  const ScrollToMessage(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class GetCurrentUserRecipes extends ConversationEvent {
  const GetCurrentUserRecipes();
}

final class ChangeMessagesToDisplay extends ConversationEvent {
  const ChangeMessagesToDisplay();
}