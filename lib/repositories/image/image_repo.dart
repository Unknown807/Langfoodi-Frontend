import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';
import 'package:equatable/equatable.dart';

export 'image_repo.dart';
part 'contracts/signed_upload_contract.dart';
part 'contracts/signed_delete_contract.dart';
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

  Future<Signature?> getSignature({String? publicId}) async {
    final response = await request.postWithoutBody("/image/get/cloudinary-signature${publicId == null ? "" : "?publicId=$publicId"}");
    if (!response.isOk) return null;
    return Signature.fromJsonStr(response.body, jsonWrapper);
  }

  Future<Signature?> getBulkDeletionSignature(List<String> publicIds) async {
    final response = await request.post("/image/get/cloudinary-signature/bulk-delete", publicIds, jsonWrapper);
    if (!response.isOk) return null;
    return Signature.fromJsonStr(response.body, jsonWrapper);
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

  Future<bool> removeImages(List<String> publicIds) async {
    final signature = await getBulkDeletionSignature(publicIds);
    if (signature == null) return false;

    SignedDeleteContract contract = SignedDeleteContract(
      signature.signature,
      signature.timeStamp,
      cloudinaryConfig.config.cloudConfig.apiKey!,
      publicIds,
    );

    final response = await request.multipartRequest(
      "DELETE",
      "/v1_1/${cloudinaryConfig.config.cloudConfig.cloudName}/resources/image/upload",
      contract.toJson(),
      baseUrl: baseUrl
    );

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