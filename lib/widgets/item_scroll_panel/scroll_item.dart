part of 'package:recipe_social_media/widgets/shared_widgets.dart';

class ScrollItem extends Equatable {
  const ScrollItem(this.id, this.title, {this.urlImage, this.show = true});

  final String id;
  final String title;
  final String? urlImage;
  final bool show;

  @override
  List<Object?> get props => [id, urlImage, title, show];
}
