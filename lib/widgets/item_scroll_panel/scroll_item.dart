part of 'package:recipe_social_media/widgets/shared_widgets.dart';

class ScrollItem extends Equatable {
  const ScrollItem(this.urlImage, this.title, {this.subtitle, this.show = true});

  final String urlImage;
  final String title;
  final String? subtitle;
  final bool show;

  @override
  List<Object?> get props => [urlImage, title, subtitle];
}
