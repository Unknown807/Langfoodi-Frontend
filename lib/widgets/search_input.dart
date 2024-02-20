part of 'shared_widgets.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.textController,
    required this.inputLabel,
    required this.onSubmit,
    required this.onTap,
    this.outerPadding = const EdgeInsets.fromLTRB(20, 20, 10, 20)
  });

  final Function(String) onSubmit;
  final VoidCallback onTap;
  final TextEditingController textController;
  final String inputLabel;
  final EdgeInsets outerPadding;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: FormInput(
            textController: textController,
            outerPadding: outerPadding,
            innerPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelText: inputLabel,
            boxDecorationType: FormInputBoxDecorationType.textArea,
            fontSize: 18,
            eventFunc: (_) {},
            onSubmittedEventFunc: (value) => onSubmit.call(value)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: ClipOval(
            child: Material(
              color: Theme.of(context).colorScheme.primary, // Button color
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.secondary, // Splash color
                child: SizedBox(
                  width: 46,
                  height: 46,
                  child: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                ),
                onTap: () => onTap.call()
              ),
            ),
          ),
        )
      ],
    );
  }
}