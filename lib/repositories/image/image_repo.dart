import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:equatable/equatable.dart';

export 'image_repo.dart';
part 'contracts/signed_upload_contract.dart';
part 'models/hosted_image.dart';
part 'models/signature.dart';

class ImageRepository {
  static final ImageRepository _instance = ImageRepository._internal();
  final String baseUrl = "https://api.cloudinary.com";

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

  @visibleForTesting
  Future<Signature?> getSignature({String? publicId}) async {
    final response = await request.postWithoutBody("/auth/get/cloudinary-signature${publicId == null ? "" : "?publicId=$publicId"}");
    if (!response.isOk) return null;

    final jsonSignature = jsonWrapper.decodeData(response.body);
    return Signature.fromJson(jsonSignature);
  }

  Future<HostedImage?> uploadImage(String filePath) async {
    final signature = await getSignature();
    if (signature == null) return null;

    final contract = SignedUploadContract(
      signature.signature,
      cloudinaryConfig.config.cloudConfig.apiKey!,
      signature.timeStamp);

    final response = await request.fileUpload(
      "/v1_1/${cloudinaryConfig.config.cloudConfig.cloudName}/image/upload",
      filePath, contract.toJson(),
      baseUrl: baseUrl);

    if (!response.isOk) return null;

    final responseData = await response.stream.toBytes();
    final jsonHostedImage = jsonWrapper.decodeData(String.fromCharCodes(responseData));
    return HostedImage.fromJson(jsonHostedImage);
  }

  Future<bool> removeImage(String publicId) async {
    final signature = await getSignature(publicId: publicId);
    if (signature == null) return false;

    final cloudName = cloudinaryConfig.config.cloudConfig.cloudName;
    final apiKey = cloudinaryConfig.config.cloudConfig.apiKey;
    final response = await request.postWithoutBody(
        "/v1_1/$cloudName/image/destroy?public_id=$publicId&api_key=$apiKey&signature=${signature.signature}&timestamp=${signature.timeStamp}",
        baseUrl: baseUrl);

    return response.isOk;
  }
}