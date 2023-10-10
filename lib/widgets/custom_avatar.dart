part of 'shared_widgets.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.size
});

  final double? size;

  @override
  Widget build(BuildContext context){
    return CircleAvatar(
        radius:size,
        backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")
    );
  }
}