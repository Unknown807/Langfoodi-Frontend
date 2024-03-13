part of 'extensions.dart';

extension StringExtension on String {
  String capitalise() {
    return isEmpty
      ? "" : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  removeFirstLeadingZero(){
    if(substring(0,1) == "0") return substring(1,);
    return this;

  }
}
