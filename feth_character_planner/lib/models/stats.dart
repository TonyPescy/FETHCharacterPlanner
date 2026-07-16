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
  // Returns: List lowLuckStats - List of all calculated stats in order
  List<int> getLowLuckStats() {

    

    // TEMP
    List<int> newList = [0, 2];
    return newList;
  }









}