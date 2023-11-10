part of 'package:recipe_social_media/repositories/image/image_repo.dart';

class SignedUploadContract with JsonConvertible {
  SignedUploadContract(this.signature, this.apiKey, this.timeStamp);

  final String signature;
  final String apiKey;
  final String timeStamp;

  @override
  Map<String, String> toJson() {
    return {
      "api_key": apiKey,
      "signature": signature,
      "timestamp": timeStamp
    };
  }
}