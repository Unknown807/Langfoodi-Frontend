part of 'package:recipe_social_media/repositories/image/image_repo.dart';

class SignedUploadContract with JsonConvertible {
  SignedUploadContract(this.signature, this.timeStamp, {this.apiKey});

  final String signature;
  final String timeStamp;
  late String? apiKey;

  set newApiKey(String apiKey) {
    this.apiKey = apiKey;
  }

  @override
  Map<String, String> toJson() {
    return {
      "api_key": apiKey ?? "",
      "signature": signature,
      "timestamp": timeStamp
    };
  }
}