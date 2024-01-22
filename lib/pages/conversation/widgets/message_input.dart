part of 'conversation_widgets.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return FormInput(
      //textController: state.ingredientNameTextController,
      innerPadding: const EdgeInsets.symmetric(horizontal: 10),
      outerPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
      hintText: "Message...",
      boxDecorationType: FormInputBoxDecorationType.roundedTextArea,
      fontSize: 14,
      maxLines: 1,
      onSubmittedEventFunc: (value) {
        print(value);
      },
      eventFunc: (value) {
        print(value);
      });
  }
}