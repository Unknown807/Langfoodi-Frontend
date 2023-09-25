import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_social_media/repositories/recipe/recipe_repo.dart';

@immutable
sealed class RecipeViewPageEvent extends Equatable {
  const RecipeViewPageEvent();

  @override
  List<Object> get props => [];
}

final class ChangeRecipesToDisplay extends RecipeViewPageEvent {
  const ChangeRecipesToDisplay();
}