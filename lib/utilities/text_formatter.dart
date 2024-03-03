part of 'utilities.dart';

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
      formattedCookingTime += "${removeFirstLeadingZero(hours)}h";
    }

    if(minutes != "00"){
      formattedCookingTime += "${removeFirstLeadingZero(minutes)}m";
    }

    return formattedCookingTime;
  }

  static String servingInformationFormatter(String servingNumber, String servingQuantity, String servingMeasurement, String kiloCalories)
  {
    if(servingQuantity == ""){
      return "";
    }

    if(servingQuantity != "" && kiloCalories == ""){
      var servingWord = "servings";
      if(servingNumber == "1"){
        servingWord = "serving";
      }
      return "$servingWord of $servingQuantity $servingMeasurement";
    }

    // if(servingQuantity == "" && kiloCalories != ""){
    //   return "$kiloCalories kcal in a serving";
    // }

    if(servingQuantity != "" && kiloCalories != ""){
      return "$kiloCalories kcal in a $servingQuantity $servingMeasurement serving";
    }

    else {
      throw ArgumentError("servingNumber:'$servingNumber', servingQuantity: '$servingQuantity', servingMeasurement: '$servingMeasurement', kiloCalories: '$kiloCalories' ");
    }

  }

  static String removeFirstLeadingZero(String number){
    if(number.substring(0,1) == "0") return number.substring(1,);
    return number;

  }
}