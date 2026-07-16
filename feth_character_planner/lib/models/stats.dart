import 'dart:convert';
import 'package:flutter/services.dart';

class Stats {
  // Constant stat abbreviations in order of appeArance - Used for displaying and more
  static const statsList = ["HP", "Str", "Mag", "Dex", "Spd", "Lck", "Def", "Res", "Cha"];
  // Links to JSON files containing growths, base stats, etc
  static const baseStatsLinks = "feth_character_planner\\assets\\data\\fe3h_character_base_stats.json";
  static const characterGrowthLink = "feth_character_planner\\assets\\data\\fe3h_class_growth_rates.json";
  static const classGrowthLink = "feth_character_planner\\assets\\data\\fe3h_character_growth_rates.json";
  static const characterMaxStatsLink = "feth_character_planner\\assets\\data\\fe3h_character_max_stats.json";


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
  Future<Map<String, double>> getLowLuckStats(String characterID, Map classLevels) async {
    // Get base stats to add growing stats to
    Map<String, double> predictedStats = await getCharacterBaseStats(characterID);

    // Iterate through each class in classLevels
    classLevels.forEach((characterClass, levels) async {
      // Get combined growth rates for this character and class combination
      Map<String, double> growthsForLevels = await getCombinedGrowthRates(characterID, characterClass);
      // In each class iterate through all growth stats
      growthsForLevels.forEach( (stat, growthRate) {
        // Get levels that will be gained for this stat during these levels spent as this class
        double levelsGained = (growthRate * levels).round() as double;
        predictedStats[stat] = predictedStats[stat]! + levelsGained;
      });

    });
    
    // Get max stats
    Map<String, double> maxStats = await getCharacterMaxStats(characterID);

    // Iterate through stats once again - Checking for max stats before returning
    predictedStats.forEach((stat, statValue) async { 
      // If predicted stat is higher than the max stat value for this character
      if (statValue > maxStats[stat]!) {
        predictedStats[stat] = maxStats[stat]!;   // Lower stat to the max
      }
      // Else nothing happens and stats remain unchanged
    });

    return predictedStats;
  }
  // Get Low Luck Stats End

  // Get Character Growth Rates Start
  // Parameters: string characterID - used to find stats/growths attributed to the character,
  Future<Map<String, double>> getCharacterGrowthRates(String characterID) async {
    // Load the JSON file
    final String jsonString = await rootBundle.loadString(characterGrowthLink);

    // Decode into a List
    final List<dynamic> data = json.decode(jsonString);

    // Find the character
    final Map<String, dynamic> character = data.firstWhere(
      (c) => c["name"] == characterID.toLowerCase(),    // Needs to be lower case as it may be used for looking up files
      orElse: () => throw Exception("Character '$characterID' not found."),
    );

    // Return the growths
    return {
      "HP": double.parse(character["HP"]),
      "Str": double.parse(character["Str"]),
      "Mag": double.parse(character["Mag"]),
      "Dex": double.parse(character["Dex"]),
      "Spd": double.parse(character["Spd"]),
      "Lck": double.parse(character["Lck"]),
      "Def": double.parse(character["Def"]),
      "Res": double.parse(character["Res"]),
      "Cha": double.parse(character["Cha"]),
    };
  }
  // Get Character Growth Rates End

  // Get Class Growth Rates Start
  // Parameters: string characterID - used to find stats/growths attributed to the character,
  Future<Map<String, double>> getClassGrowthRates(String classID) async {
    // Load the JSON file
    final String jsonString = await rootBundle.loadString(classGrowthLink);

    // Decode into a List
    final List<dynamic> data = json.decode(jsonString);

    // Find the character
    final Map<String, dynamic> unitClass = data.firstWhere(
      (c) => c["name"] == classID,    // Does not need to be lowercase
      orElse: () => throw Exception("Character '$classID' not found."),
    );

    // Return the growths
    return {
      "HP": double.parse(unitClass["HP"]),
      "Str": double.parse(unitClass["Str"]),
      "Mag": double.parse(unitClass["Mag"]),
      "Dex": double.parse(unitClass["Dex"]),
      "Spd": double.parse(unitClass["Spd"]),
      "Lck": double.parse(unitClass["Lck"]),
      "Def": double.parse(unitClass["Def"]),
      "Res": double.parse(unitClass["Res"]),
      "Cha": double.parse(unitClass["Cha"]),
    };
  }
  // Get Class Growth Rates End

  // Get Character Base Stats Start
  // Parameters: string characterID - used to find stats/growths attributed to the character,
  Future<Map<String, double>> getCharacterBaseStats(String characterID) async {
    // Load the JSON file
    final String jsonString = await rootBundle.loadString(baseStatsLinks);

    // Decode into a List
    final List<dynamic> data = json.decode(jsonString);

    // Find the character
    final Map<String, dynamic> baseStats = data.firstWhere(
      (c) => c["name"] == characterID.toLowerCase(),   // Needs to be lower case as it may be used for looking up files
      orElse: () => throw Exception("Character '$characterID' not found."),
    );

    // Return the growths
    return {
      "HP": double.parse(baseStats["HP"]),
      "Str": double.parse(baseStats["Str"]),
      "Mag": double.parse(baseStats["Mag"]),
      "Dex": double.parse(baseStats["Dex"]),
      "Spd": double.parse(baseStats["Spd"]),
      "Lck": double.parse(baseStats["Lck"]),
      "Def": double.parse(baseStats["Def"]),
      "Res": double.parse(baseStats["Res"]),
      "Cha": double.parse(baseStats["Cha"]),
    };
  }
  // Get Character Base Stats End

  // Get Combined Growth Rates Start
  // Parameters: string characterID - used to find stats/growths attributed to the character,
  //    string classID - used to find stats/growths attributed to the class
  // Return: Map<statName, statValue> - Combined froim character and class Maps
  Future<Map<String, double>> getCombinedGrowthRates(String characterID, String classID) async {
    // Get growth rates
    Map<String, double> characterGrowthRates = await getCharacterGrowthRates(characterID);
    Map<String, double> classGrowthRates = await getClassGrowthRates(classID);

    // Combine growth rates
    double hpGrowth  = characterGrowthRates["HP"]!  + classGrowthRates["HP"]!;
    double strGrowth = characterGrowthRates["Str"]! + classGrowthRates["Str"]!;
    double magGrowth = characterGrowthRates["Mag"]! + classGrowthRates["Mag"]!;
    double dexGrowth = characterGrowthRates["Dex"]! + classGrowthRates["Dex"]!;
    double spdGrowth = characterGrowthRates["Spd"]! + classGrowthRates["Spd"]!;
    double lckGrowth = characterGrowthRates["Lck"]! + classGrowthRates["Lck"]!;
    double defGrowth = characterGrowthRates["Def"]! + classGrowthRates["Def"]!;
    double resGrowth = characterGrowthRates["Res"]! + classGrowthRates["Res"]!;
    double chaGrowth = characterGrowthRates["Cha"]! + classGrowthRates["Cha"]!;

    return {
      "HP": hpGrowth,
      "Str": strGrowth,
      "Mag": magGrowth,
      "Dex": dexGrowth,
      "Spd": spdGrowth,
      "Lck": lckGrowth,
      "Def": defGrowth,
      "Res": resGrowth,
      "Cha": chaGrowth,
    };
  }
  // Get Combined Growth Rates End

  // Get Character Base Stats Start
  // Parameters: string characterID - used to find stats/growths attributed to the character,
  Future<Map<String, double>> getCharacterMaxStats(String characterID) async {
    // Load the JSON file
    final String jsonString = await rootBundle.loadString(characterMaxStatsLink);

    // Decode into a List
    final List<dynamic> data = json.decode(jsonString);

    // Find the character
    final Map<String, dynamic> maxsStats = data.firstWhere(
      (c) => c["name"] == characterID.toLowerCase(),   // Needs to be lower case as it may be used for looking up files
      orElse: () => throw Exception("Character '$characterID' not found."),
    );

    // Return the growths
    return {
      "HP": double.parse(maxsStats["HP"]),
      "Str": double.parse(maxsStats["Str"]),
      "Mag": double.parse(maxsStats["Mag"]),
      "Dex": double.parse(maxsStats["Dex"]),
      "Spd": double.parse(maxsStats["Spd"]),
      "Lck": double.parse(maxsStats["Lck"]),
      "Def": double.parse(maxsStats["Def"]),
      "Res": double.parse(maxsStats["Res"]),
      "Cha": double.parse(maxsStats["Cha"]),
    };
  }
  // Get Character Base Stats End


}