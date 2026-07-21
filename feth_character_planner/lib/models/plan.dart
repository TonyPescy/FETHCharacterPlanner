// Plan start
class Plan {
  String id;
  String type;
  String name;
  String image;
  List<PlanCharacter> characters;

  Plan({
    required this.id,
    required this.type,
    required this.name,
    required this.image,
    required this.characters,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      image: json["image"],
      characters: (json["characters"] as List)
          .map((character) => PlanCharacter.fromJson(character))
          .toList(),
    );
  }
}
// Plan End

// Plan Character Start
class PlanCharacter {
  String id;
  List<ClassHistory> classes;
  StatsPrediction stats;

  PlanCharacter({
    required this.id,
    required this.classes,
    required this.stats,
  });

  factory PlanCharacter.fromJson(Map<String, dynamic> json) {
    return PlanCharacter(
      id: json["id"],

      classes: (json["classes"] as List)
          .map((classData) => ClassHistory.fromJson(classData))
          .toList(),

      stats: StatsPrediction.fromJson(
        json["stats"][0],
      ),
    );
  }

  String get currentClass {
    return classes.last.name;
  }

  int get level {
    return classes.fold(
      0,
      (sum, item) => sum + item.levels,
    );
  }
}
// Plan Character End

// Class History Start
class ClassHistory {
  String name;
  int levels;

  ClassHistory({
    required this.name,
    required this.levels,
  });

  factory ClassHistory.fromJson(Map<String, dynamic> json) {
    return ClassHistory(
      name: json["name"],
      levels: json["levels"],
    );
  }

  // to Map functon
  Map<String, int> toMap(){
    return {
      name: levels,
    };
  }
}
// Class History End

// Stats Prediction Start
class StatsPrediction {
  Map<String, double> rng1;
  Map<String, double> rng2;
  Map<String, double> rng3;

  StatsPrediction({
    required this.rng1,
    required this.rng2,
    required this.rng3,
  });


  factory StatsPrediction.fromJson(Map<String, dynamic> json) {

    return StatsPrediction(

      rng1: _convertStats(
        json["rng1"][0],
      ),

      rng2: _convertStats(
        json["rng2"][0],
      ),

      rng3: _convertStats(
        json["rng3"][0],
      ),

    );
  }


  static Map<String,double> _convertStats(
      Map<String,dynamic> stats
  ){

    return stats.map(
      (key,value) =>
        MapEntry(
          key,
          value,
        ),
    );

  }
}
// Stats Prediction End