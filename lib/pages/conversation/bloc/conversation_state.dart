part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    required this.messageListScrollController,
    required this.messageTextController,
    this.conversationName = "",
    this.conversationStatus = ConversationStatus.connected,
    this.isGroup = false,
    this.fetchRecipes = true,
    this.messages = const [],
    this.senderId = "",
    this.nameColours = const {},
    this.dialogTitle = "",
    this.dialogMessage = "",
    this.currentRecipes = const [],
    this.checkboxValues = const [],
    this.pageLoading = false,
    this.conversationId = ""
  });

  final GroupedItemScrollController messageListScrollController;
  final TextEditingController messageTextController;
  final ConversationStatus conversationStatus;
  final String senderId;
  final String conversationName;
  final bool isGroup;
  final bool fetchRecipes;
  final bool pageLoading;
  final List<Message> messages;
  final List<Recipe> currentRecipes;
  final List<bool> checkboxValues;
  final Map<String, Color> nameColours;
  final String dialogTitle;
  final String dialogMessage;
  final String conversationId;

  @override
  List<Object> get props => [
    conversationName, messages, isGroup,
    senderId, conversationStatus, nameColours,
    messageTextController, dialogTitle, dialogMessage,
    fetchRecipes, currentRecipes, checkboxValues,
    messageListScrollController, pageLoading,
    conversationId
  ];

  ConversationState copyWith({
    String? conversationName,
    List<Message>? messages,
    bool? isGroup,
    String? senderId,
    ConversationStatus? conversationStatus,
    Map<String, Color>? nameColours,
    TextEditingController? messageTextController,
    GroupedItemScrollController? messageListScrollController,
    String? dialogTitle,
    String? dialogMessage,
    bool? fetchRecipes,
    List<Recipe>? currentRecipes,
    List<bool>? checkboxValues,
    bool? pageLoading,
    String? conversationId
  }) {
    return ConversationState(
      conversationName: conversationName ?? this.conversationName,
      messages: messages ?? this.messages,
      isGroup: isGroup ?? this.isGroup,
      senderId: senderId ?? this.senderId,
      conversationStatus: conversationStatus ?? this.conversationStatus,
      nameColours: nameColours ?? this.nameColours,
      messageTextController: messageTextController ?? this.messageTextController,
      messageListScrollController: messageListScrollController ?? this.messageListScrollController,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      currentRecipes: currentRecipes ?? this.currentRecipes,
      fetchRecipes: fetchRecipes ?? this.fetchRecipes,
      checkboxValues: checkboxValues ?? this.checkboxValues,
      pageLoading: pageLoading ?? this.pageLoading,
      conversationId: conversationId ?? this.conversationId
    );
  }
}