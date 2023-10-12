part of 'package:recipe_social_media/repositories/image/image_repo.dart';

class Signature extends Equatable with JsonConvertible {
  const Signature(this.signature, this.timeStamp);

  final String signature;
  final String timeStamp;

  @override
  List<Object?> get props => [signature, timeStamp];

  static Signature fromJson(Map jsonData) {
    return Signature(
        jsonData["signature"],
        jsonData["timeStamp"].toString());
  }
}