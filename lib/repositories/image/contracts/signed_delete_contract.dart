part of 'package:recipe_social_media/repositories/image/image_repo.dart';

class SignedDeleteContract with JsonConvertible {
  SignedDeleteContract(
    this.signature,
    this.timeStamp,
    this.apiKey,
    this.publicIds,
  );

  final String signature;
  final String timeStamp;
  final String apiKey;
  final List<String> publicIds;

  @override
  Map<String, String> toJson() {
    Map<String, String> params = {};

    for (int i = 0; i < publicIds.length; i++) {
      params["public_ids[$i]"] = publicIds[i];
    }

    params["api_key"] = apiKey;
    params["signature"] = signature;
    params["timestamp"] = timeStamp;

    return params;
  }
}