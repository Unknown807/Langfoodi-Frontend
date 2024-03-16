part of 'recipe_interaction_widgets.dart';

class TextFormatter {
  static String cookingTimeFormatter(String cookingTime){

    // Check the format of cookingTime to make sure it can be separated into hours and minutes
    var cookingTimeFormat = RegExp(r"\d\d:\d\d:\d\d");
    if (!cookingTimeFormat.hasMatch(cookingTime)){
      throw FormatException("cooking time '$cookingTime' does not match HH:MM:SS format.");
    }

    String formattedCookingTime = "";

    var cookingTimeElements = cookingTime.split(":");
    String hours = cookingTimeElements[0];
    String minutes = cookingTimeElements[1];

    if(hours != "00"){
      formattedCookingTime += "${hours.removeFirstLeadingZero()}h ";
    }

    if(minutes != "00"){
      formattedCookingTime += "${minutes.removeFirstLeadingZero()}m";
    }

    return formattedCookingTime.trim();
  }

  static String servingInformationFormatter(String servingNumber, String servingQuantity, String servingMeasurement, String kiloCalories)
  {
    if(servingQuantity != "" && kiloCalories == ""){
      var servingWord = "servings";
      if(servingNumber == "1"){
        servingWord = "serving";
      }
      return "$servingWord of $servingQuantity $servingMeasurement";
    }

    else if(servingQuantity != "" && kiloCalories != ""){
      return "$kiloCalories kcal in a\n$servingQuantity $servingMeasurement serving";
    }

    else{
      return "";
    }

  }
}