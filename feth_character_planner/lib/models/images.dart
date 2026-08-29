// imports
import 'package:feth_character_planner/models/plan.dart';

class Images {
  // Links to directories containing images
  static const characterImageLink = "assets/images/characters/";
  static const houseImageLink = "assets/images/house_sigils/";

  // Get Card Image Start
  // Gets image for card for the character/house
  // Parameters: Plan plan - used to find what cardType and the name/id of the image needing to be found
  // Return: string imageLink
  static String getCardImage(Plan plan) {
    // Testing
    // print("CardType: ${plan.type}");
    // print("Name: ${plan.name}");
    // print("ID: ${plan.id}");

    // Character plans use name to find image
    // house plans use id to find image
    switch (plan.type) {
      case "character":
        return "$characterImageLink${plan.name}.png";   // Creates link to file name in house_sigils
      
      case "house":
        // differentiate or translate between house and empires here
       return "$houseImageLink${plan.id}.png";  // Creates link to file name in house_sigils
    }
    return "error"; // Will display error image as image was not viable and cannot be found in assets
  }
  // Get Card Image End

}