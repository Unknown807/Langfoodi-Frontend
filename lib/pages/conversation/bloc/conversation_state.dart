part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    required this.messageListScrollController,
    required this.messageTextController,
    this.conversationName = "",
    this.isGroup = false,
    this.isBlocked = false,
    this.messages = const [],
    this.senderId = "",
    this.nameColours = const {},
    this.dialogTitle = "",
    this.dialogMessage = "",
    this.currentRecipes = const [],
    this.checkboxValues = const [],
    this.pageLoading = false,
    this.conversationId = "",
    this.attachedImagePaths = const [],
    this.attachedRecipes = const [],
    this.allowImages = true,
    this.allowRecipes = true,
    this.sendingMessage = false,
    this.repliedMessage = const Message("", UserPreviewForMessage("", "", null), [], null, null, "", "", null, null),
    this.repliedMessageIsSentByMe = false,
    this.userIds = const [],
  });

  final GroupedItemScrollController messageListScrollController;
  final TextEditingController messageTextController;
  final String senderId;
  final String conversationName;
  final bool isGroup;
  final bool isBlocked;
  final bool pageLoading;
  final List<Message> messages;
  final List<Recipe> currentRecipes;
  final List<bool> checkboxValues;
  final Map<String, Color> nameColours;
  final String dialogTitle;
  final String dialogMessage;
  final String conversationId;
  final List<String> attachedImagePaths;
  final List<Recipe> attachedRecipes;
  final bool allowImages;
  final bool allowRecipes;
  final bool sendingMessage;
  final bool repliedMessageIsSentByMe;
  final Message repliedMessage;
  final List<String> userIds;

  @override
  List<Object> get props => [
    conversationName, messages, isGroup,
    senderId, nameColours,
    messageTextController, dialogTitle, dialogMessage,
    currentRecipes, checkboxValues,
    messageListScrollController, pageLoading,
    conversationId, attachedImagePaths, allowImages,
    allowRecipes, attachedRecipes, sendingMessage,
    repliedMessage, repliedMessageIsSentByMe,
    userIds, isBlocked
  ];

  ConversationState copyWith({
    String? conversationName,
    List<Message>? messages,
    bool? isGroup,
    String? senderId,
    Map<String, Color>? nameColours,
    TextEditingController? messageTextController,
    GroupedItemScrollController? messageListScrollController,
    String? dialogTitle,
    String? dialogMessage,
    List<Recipe>? currentRecipes,
    List<bool>? checkboxValues,
    bool? pageLoading,
    String? conversationId,
    List<String>? attachedImagePaths,
    bool? allowImages,
    bool? allowRecipes,
    List<Recipe>? attachedRecipes,
    bool? sendingMessage,
    Message? repliedMessage,
    bool? repliedMessageIsSentByMe,
    List<String>? userIds,
    bool? isBlocked
  }) {
    return ConversationState(
      conversationName: conversationName ?? this.conversationName,
      messages: messages ?? this.messages,
      isGroup: isGroup ?? this.isGroup,
      senderId: senderId ?? this.senderId,
      nameColours: nameColours ?? this.nameColours,
      messageTextController: messageTextController ?? this.messageTextController,
      messageListScrollController: messageListScrollController ?? this.messageListScrollController,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      currentRecipes: currentRecipes ?? this.currentRecipes,
      checkboxValues: checkboxValues ?? this.checkboxValues,
      pageLoading: pageLoading ?? this.pageLoading,
      conversationId: conversationId ?? this.conversationId,
      attachedImagePaths: attachedImagePaths ?? this.attachedImagePaths,
      allowImages: allowImages ?? this.allowImages,
      allowRecipes: allowRecipes ?? this.allowRecipes,
      attachedRecipes: attachedRecipes ?? this.attachedRecipes,
      sendingMessage: sendingMessage ?? this.sendingMessage,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedMessageIsSentByMe: repliedMessageIsSentByMe ?? this.repliedMessageIsSentByMe,
      userIds: userIds ?? this.userIds,
      isBlocked: isBlocked ?? this.isBlocked
    );
  }
}