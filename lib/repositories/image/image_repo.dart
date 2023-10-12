import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/repositories/image/contracts/signed_upload_contract.dart';
import 'package:recipe_social_media/repositories/image/models/hosted_image.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

import 'models/signature.dart';

export 'image_repo.dart';

class ImageRepository {
  static final ImageRepository _instance = ImageRepository._internal();

  late Request request;
  late Cloudinary cloudinaryConfig;
  late JsonWrapper jsonWrapper;

  ImageRepository._internal();

  factory ImageRepository([Request? request, JsonWrapper? jsonWrapper, Cloudinary? cloudinaryConfig]) {
    _instance.request = request ?? _instance.request;
    _instance.jsonWrapper = jsonWrapper ?? _instance.jsonWrapper;
    _instance.cloudinaryConfig = cloudinaryConfig ?? _instance.cloudinaryConfig;

    return _instance;
  }

  Future<Signature?> _getSignature() async {
    final response = await request.postWithoutBody("/auth/get/cloudinary-signature");
    if (!response.isOk) return null;

    final jsonSignature = jsonWrapper.decodeData(response.body);
    return Signature.fromJson(jsonSignature);
  }

  Future<Object?> uploadImage(String filePath) async {
    final signature = await _getSignature();
    if (signature == null) return null;

    final contract = SignedUploadContract(
      signature.signature,
      cloudinaryConfig.config.cloudConfig.apiKey!,
      signature.timeStamp);

    final response = await request.fileUpload(
      "https://api.cloudinary.com/v1_1/dqy0zu53d/image/upload",
      filePath, contract.toJson());

    final responseData = await response.stream.toBytes();
    final jsonHostedImage = jsonWrapper.decodeData(String.fromCharCodes(responseData));
    return HostedImage.fromJson(jsonHostedImage);
  }
}