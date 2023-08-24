part of 'shared_widgets.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          textStyle: const MaterialStatePropertyAll(
              TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
          hintStyle: const MaterialStatePropertyAll(
              TextStyle(color: Colors.grey, fontWeight: FontWeight.normal)),
          hintText: "Search Your Recipes",
          controller: controller,
          onTap: () { controller.openView(); },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              print("thing tapped ???");
            },
          );
        });
      }),
    );
  }
}
