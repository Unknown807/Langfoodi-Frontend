part of 'utilities.dart';

class MultipartFileProvider {
  Future<MultipartFile> fromPath(String field, String filePath) {
    return MultipartFile.fromPath(field, filePath);
  }
}