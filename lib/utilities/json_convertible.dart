part of 'utilities.dart';

mixin JsonConvertible {
  Map toJson();
  dynamic fromJson() { return Object(); }
}