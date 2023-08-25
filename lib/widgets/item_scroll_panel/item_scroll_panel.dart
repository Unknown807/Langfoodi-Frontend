part of 'package:recipe_social_media/widgets/shared_widgets.dart';

class ItemScrollPanel extends StatelessWidget {
  ItemScrollPanel({super.key});

  final List<ScrollItem> items = [
    const ScrollItem(
        "https://daniscookings.com/wp-content/uploads/2021/03/Cinnamon-Roll-Cake-23.jpg",
        "cake",
        "\$12"),
    const ScrollItem(
        "https://anitalianinmykitchen.com/wp-content/uploads/2018/04/vertical-cake-sq-1-of-1.jpg",
        "really long recipe name wow!!!!",
        "\$12"),
    const ScrollItem(
        "https://embed.widencdn.net/img/beef/pygmsl7od0/1120x560px/rancher-recipe-balsamic-steak-pasta-horizontal.tif?keep=c&u=7fueml",
        "Epic name here",
        "\$12"),
    const ScrollItem(
        "https://sallysbakingaddiction.com/wp-content/uploads/2019/07/vertical-layer-cake.jpg",
        "Is this the one with steak or nah? or am I trippin?",
        "\$12"),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => buildScrollItem(context, items[index]),
          separatorBuilder: (context, _) => const SizedBox(width: 12),
          itemCount: 4),
    ));
  }

  Widget buildScrollItem(BuildContext context, ScrollItem item) {
    return Container(
      width: 200,
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          AspectRatio(
              aspectRatio: (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height) + 0.02,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                 child: Image.network(item.urlImage, fit: BoxFit.cover))),
          const SizedBox(height: 4),
          Text(item.title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          Text(item.subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
