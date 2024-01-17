import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:equatable/equatable.dart';

export 'image_repo.dart';
part 'contracts/signed_upload_contract.dart';
part 'models/hosted_image.dart';
part 'models/signature.dart';

class ImageRepository {
  ImageRepository(this.request, this.jsonWrapper, this.cloudinaryConfig);

  final String baseUrl = "https://api.cloudinary.com";

  late Request request;
  late Cloudinary cloudinaryConfig;
  late JsonWrapper jsonWrapper;

  Future<Signature?> getSignature() async {
    final response = await request.postWithoutBody("/image/get/cloudinary-signature");
    if (!response.isOk) return null;
    return Signature.fromJsonStr(response.body, jsonWrapper);
  }

  Future<bool> removeImage(String publicId) async {
    final response = await request.delete("/image/single-delete?publicId=$publicId");
    return response.isOk;
  }

  Future<bool> removeImages(List<String> publicIds) async {
    final response = await request.delete("/image/bulk-delete?publicIds=${publicIds.join("&publicIds=")}");
    return response.isOk;
  }

  Future<HostedImage?> uploadImage(String filePath, SignedUploadContract contract) async {
    contract.newApiKey = cloudinaryConfig.config.cloudConfig.apiKey!;

    final response = await request.multipartRequest(
      "POST",
      "/v1_1/${cloudinaryConfig.config.cloudConfig.cloudName}/image/upload",
      contract.toJson(),
      filePath: filePath,
      baseUrl: baseUrl
    );

    if (!response.isOk) return null;

    final responseData = await response.stream.toBytes();
    return HostedImage.fromJsonStr(String.fromCharCodes(responseData), jsonWrapper);
  }
}