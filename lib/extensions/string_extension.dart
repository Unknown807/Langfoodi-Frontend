part of 'extensions.dart';

extension StringExtension on String {
  String capitalise() {
    return isEmpty
      ? "" : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}