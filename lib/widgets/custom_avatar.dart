part of 'shared_widgets.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key
});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        child:
        const Padding(
            padding: EdgeInsets.all(16.0),
            child:
            CircleAvatar(radius:70,backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"))
        ),
        onTap:(){print("Avatar selected");});
  }
}