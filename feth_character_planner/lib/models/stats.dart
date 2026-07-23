import 'dart:convert';
import 'package:flutter/services.dart';

class Stats {
  // Constant stat abbreviations in order of appeArance - Used for displaying and more
  static const statsList = ["HP", "Str", "Mag", "Dex", "Spd", "Lck", "Def", "Res", "Cha"];
  static const numOfGenerations = 4.0;
  // Links to JSON files containing growths, base stats, etc
  static const baseStatsLinks = "assets/data/fe3h_character_base_stats.json";
  static const characterGrowthLink = "assets/data/fe3h_character_growth_rates.json";
  static const classGrowthLink = "assets/data/fe3h_class_growth_rates.json";
  static const characterMaxStatsLink = "assets/data/fe3h_character_max_stats.json";

  static String _normalizeName(String value) {
    return value.trim().toLowerCase();
  }

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
  Future<Map<String, double>> getLowLuckStats(String characterID, Map<String, double> classLevels) async {
    // Debug
    print("GetLowLuckStats characterID: $characterID");
    // Get base stats to add growing stats to
    Map<String, double> predictedStats = await getCharacterBaseStats(characterID);

    // Debug
    print("BaseStats characterID: $characterID");

    // Iterate through each class in classLevels
    classLevels.forEach((characterClass, levels) async {
      // Get combined growth rates for this character and class combination
      Map<String, double> growthsForLevels = await getCombinedGrowthRates(characterID, characterClass);
      // In each class iterate through all growth stats
      growthsForLevels.forEach((stat, growthRate) {
        // DEBUG 
        print("LOWLUCKCALC: $stat Growth: $growthRate");
        double growthRatePercent = growthRate * 0.01;
        print("LOWLUCKCALC: $stat Growth as %: $growthRatePercent");
        // Get levels that will be gained for this stat during these levels spent as this class
        double levelsGained = (growthRatePercent * levels); // Divides by 10 to convert to percent
        levelsGained = levelsGained.round().toDouble();
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
      (c) => _normalizeName(c["name"].toString()) == _normalizeName(characterID),
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
      (c) => _normalizeName(c["name"].toString()) == _normalizeName(classID),
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
    // Debug
    print("GetBaseStats characterID: $characterID");
    // Debug
    print("BaseStats Link: $baseStatsLinks");
    // Load the JSON file
    final String jsonString = await rootBundle.loadString(baseStatsLinks);

    // Decode into a List
    final List<dynamic> data = json.decode(jsonString);

    // Find the character
    final Map<String, dynamic> baseStats = data.firstWhere(
      (c) => _normalizeName(c["name"].toString()) == _normalizeName(characterID),
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
      (c) => _normalizeName(c["name"].toString()) == _normalizeName(characterID),
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

  // Get Average Stats Start
  // Calculates average stats for the character
  // Combines all stats from other generations for their character then divides by 4 (# of prior generatons)
  // Parameters: string characterID - used to find max stats attributed to the character,
  //      Maps gen0-3
  //          stat: stat name
  //          statVal: current value of that stat
  // Returns: Map averageStats - List of all calculated stats in order
  //            stat: stat name
  //            statVal: how much of a stat the char has
  Future<Map<String, double>> getAverageStats(String characterID, Map<String, double> gen0, Map<String, double> gen1, Map<String, double> gen2, Map<String, double> gen3,) async {
    // Declare averageStats map as empty map
    Map<String, double> averageStats = {};
    // Get max stats
    Map<String, double> maxStats = await getCharacterMaxStats(characterID);

    // Iterate through all stats in statList to access values in gen0-gen3, averageStats, and maxStats
    for (String stat in statsList) {
      // DEBUG
      print("Gen0 $stat: ${gen0[stat]!}");
      print("Gen1 $stat: ${gen1[stat]!}");
      print("Gen2 $stat: ${gen2[stat]!}");
      print("Gen3 $stat: ${gen3[stat]!}");
      print((gen0[stat]! + gen1[stat]! + gen2[stat]! + gen3[stat]!).toString());

      // Get stats from gen0-gen3 and combine to get average stats
      // For each stat calculate the average stat and add it to averageStats Map 
      double tempStat = (((gen0[stat]! + gen1[stat]! + gen2[stat]! + gen3[stat]!) / (numOfGenerations))).toDouble(); // Get average for stat - Rounded to nearest whole number
      
      // Round and convert back to double for use in averageStats Map
      tempStat = tempStat.round().toDouble();

      // Debug - To be removed/commented out
      print("Average stat Calculation BEFORE max stat is considered: $stat: $tempStat! Max is: $maxStats[stat]");

      // Compare to max stats and set to max value, if and only if the max value was exceeded
      if (tempStat > maxStats[stat]!) {
        tempStat = maxStats[stat]!;   // Set to max stat value
      }

      // Debug - To be removed/commented out
      print("Average stat Calculation AFTER max stat is considered: $stat: $tempStat! Max is: $maxStats[stat]");
    
      // Assign tempStat to averageStats
      averageStats[stat] = tempStat;
    }

    return averageStats;
  }
  // Get Low Luck Stats End


}