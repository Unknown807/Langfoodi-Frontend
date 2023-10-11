import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:recipe_social_media/api/api.dart';
import 'package:recipe_social_media/utilities/utilities.dart';

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
}