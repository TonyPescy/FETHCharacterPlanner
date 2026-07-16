import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

class Stats {
  // Constant stat abbreviations in order of apperance - Used for displaying and more
  static const statsList = ["HP", "Str", "Mag", "Dex", "Spd", "Lck", "Def", "Res", "Cha"];

  // Get Low Luck Stats Start
  // Calculates low-luck stats for the character
  // Low-luck assumes you will hit a 10% chance only once out of 10 tries
  // Parameters: string characterID - used to find stats/growths attributed to the character,
  //      Map classLevels
  //          name: Class name - Used for finding class growths
  //          levels: levels spent in class - Used for calculating how long someone is in a class
  // Returns: Map lowLuckStats - List of all calculated stats in order
  //            stat: stat name
  //            statVal: how much of a stat the char has
  List<int> getLowLuckStats(String characterID, Map classLevels) {

    

    // TEMP
    List<int> newList = [0, 2];
    return newList;
  }
  // Get Low Luck Stats End

  // Get Character Growth Rates Start
  Map<String, Float> getCharacterGrowthRates(String characterID) {
    throw UnimplementedError("NOT IMPLEMENTED YET!");
  }
  // Get Character Growth Rates End

  // Get Class Growth Rates Start
  Map<String, Float> getClassGrowthRates(String classID) {
    throw UnimplementedError("NOT IMPLEMENTED YET!");
  }
  // Get Class Growth Rates End

  // Get Character Base Stats Start
  Map<String, Float> getCharacterBaseStats(String characterID) {
    throw UnimplementedError("NOT IMPLEMENTED YET!");
  }
  // Get Character Base Stats End

  // Get Combined Growth Rates Start
  Map<String, Float> getCombinedGrowthRates(String characterID, String classID) {
    throw UnimplementedError("NOT IMPLEMENTED YET!");
  }
  // Get Combined Growth Rates End





}