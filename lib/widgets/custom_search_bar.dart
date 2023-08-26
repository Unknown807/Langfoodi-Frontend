part of 'shared_widgets.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChangedFunc,
    required this.suggestionsBuilder,
    required this.hintText,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey
  });

  final Color textColor;
  final Color hintColor;
  final String hintText;
  final Function(String?) onChangedFunc;
  final SuggestionsBuilder suggestionsBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          textStyle: MaterialStatePropertyAll(
              TextStyle(color: textColor, fontWeight: FontWeight.normal)),
          hintStyle: MaterialStatePropertyAll(
              TextStyle(color: hintColor, fontWeight: FontWeight.normal)),
          hintText: hintText,
          controller: controller,
          onChanged: (changedTxt) {
            onChangedFunc(changedTxt);
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      }, suggestionsBuilder: suggestionsBuilder,
    ));
  }
}
