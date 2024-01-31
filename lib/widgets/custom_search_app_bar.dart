part of 'shared_widgets.dart';

class CustomSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomSearchAppBar({
    super.key,
    required this.title,
    required this.onSearchFunc,
    this.suggestions,
    this.hintText = "",
    this.actions = const []
  });

  final Widget title;
  final String hintText;
  final List<Widget> actions;
  final Function(String) onSearchFunc;
  final List<String>? suggestions;

  @override
  Widget build(BuildContext context) {
    return EasySearchBar(
      title: title,
      actions: actions,
      putActionsOnRight: true,
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary, size: 25),
      titleTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
      searchHintText: hintText,
      searchBackgroundColor: Theme.of(context).colorScheme.background,
      searchHintStyle: TextStyle(fontSize: 20, color: Theme.of(context).hintColor),
      searchTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
      searchClearIconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
      searchBackIconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
      searchCursorColor: Theme.of(context).colorScheme.tertiary,
      suggestionBuilder: (suggestion) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(suggestion,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onBackground)),
        );
      },
      suggestions: suggestions,
      onSearch: (value) => onSearchFunc.call(value),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
