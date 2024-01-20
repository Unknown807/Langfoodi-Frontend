part of 'form_widgets.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.eventFunc,
    required this.text,
  });

  final String text;
  final VoidCallback? eventFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary
      ),
      onPressed: eventFunc,
      child: Text(text),
    );
  }
}